server "51.15.67.2", user: "deployer", roles: %w{app web}, primary: true

role :app, %w{deployer@51.15.67.2}
role :web, %w{deployer@51.15.67.2}

set :stage, :production

 set :ssh_options, {
  keys: %w(/home/muxa/.ssh/ror_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password),
  port: 4321
 }
