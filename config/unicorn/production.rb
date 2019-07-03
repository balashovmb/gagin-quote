# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = "/home/deployer/gagin-quote"
worker_processes 2
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "#{@dir}/shared/tmp/sockets/unicorn-gq.sock", :backlog => 64

# Set process id path
pid "#{@dir}/shared/tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}/shared/log/unicorn.stderr.log"
stdout_path "#{@dir}/shared/log/unicorn.stdout.log"
