#!/usr/bin/env puma

# The directory to operate out of.
directory "/home/ubuntu/deploy/rails_seven_exploring/current"

preload_app!

# Set the environment in which the rack's app will run. The value must be a string.
# The default is "development".
environment "production"

# Daemonize the server into the background. Highly suggest that
# this be combined with "pidfile" and "stdout_redirect".
#
# The default is "false".
#
# daemonize
daemonize true

# Store the pid of the server in the file at "path".
# pidfile '/u/apps/lolcat/tmp/pids/puma.pid'

pidfile  "tmp/pids/puma.pid"

# Use "path" as the file to store the server info state. This is
# used by "pumactl" to query and control the server.
# state_path '/u/apps/lolcat/tmp/pids/puma.state'
state_path "tmp/pids/puma.state"

# Redirect STDOUT and STDERR to files specified. The 3rd parameter
# ("append") specifies whether the output is appended, the default is
# "false".
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr'
# stdout_redirect '/u/apps/lolcat/log/stdout', '/u/apps/lolcat/log/stderr', true
stdout_redirect "log/puma.stdout.log", "log/puma.stderr.log", true


# Disable request logging.
# The default is "false".
quiet

# How many worker processes to run.
# The default is "0".
workers 4

# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
# The default is "0, 16".
threads 0, 16

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
# The default is "tcp://0.0.0.0:9292".
# bind 'tcp://0.0.0.0:9292'
# bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0777'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'
bind "unix://tmp/sockets/puma.sock"

# Code to run before doing a restart. This code should
# close log files, database connections, etc.
#
# This can be called multiple times to add code each time.
#
# on_restart do
#   puts 'On restart...'
# end
on_restart do
  puts 'On restart...'
end

# === Cluster mode ===

# Code to run immediately before the master starts workers.
#
# before_fork do
#   puts "Starting workers..."
# end
before_fork do
  puts "Starting workers..."
end

# Code to run in a worker before it starts serving requests.
#
# This is called everytime a worker is to be started.
#
# on_worker_boot do
#   puts 'On worker boot...'
# end
on_worker_boot do
  puts "On worker boot..."
end

# Code to run in a worker right before it exits.
#
# This is called everytime a worker is to about to shutdown.
#
# on_worker_shutdown do
#   puts 'On worker shutdown...'
# end
on_worker_shutdown do
  puts "On worker shutdown..."
end

# Code to run in the master right before a worker is started. The worker's
# index is passed as an argument.
#
# This is called everytime a worker is to be started.
#
# on_worker_fork do
#   puts 'Before worker fork...'
# end
on_worker_fork do |worker_id|
  puts "Before worker #{worker_id} fork..."
end

# Code to run in the master after a worker has been started. The worker's
# index is passed as an argument.
#
# This is called everytime a worker is to be started.
#
# after_worker_fork do
#   puts 'After worker fork...'
# end
after_worker_fork do |worker_id|
  puts "After worker #{worker_id} fork..."
end

# Change the default timeout of worker startup
# The default is 60
worker_timeout 600

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart if Gem.loaded_specs['puma'].version >= Gem::Version.new('3.0')
