require "google/apis/docs_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "fileutils"

class Quote::GetFromGoogleDocs < Service
  OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
  APPLICATION_NAME = "Google Docs API Ruby Quickstart".freeze
  CREDENTIALS_PATH = "credentials.json".freeze
  TOKEN_PATH = "token.yaml".freeze
  SCOPE = Google::Apis::DocsV1::AUTH_DOCUMENTS_READONLY


  def call
    document_to_file
  end

  private

  def authorize
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = "default"
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url base_url: OOB_URI
      puts "Open the following URL in the browser and enter the " \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def document
    service = Google::Apis::DocsV1::DocsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize
    document_id = ENV["GOOGLE_DOC_ID"]
    service.get_document document_id
  end

  def document_to_file
    File.open("./quotes.txt", "w") do |f|
      document.body.content.each do |cont|
        f << (cont.paragraph.to_h[:elements].first[:text_run][:content]) if cont.paragraph
      end
    end
  end
end
