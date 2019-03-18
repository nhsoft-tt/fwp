# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

server '52.197.38.237', user: 'deploy', roles: %w{app db web}, my_property: :my_value

set :scm, :git

set :rails_env, "staging"
set :rvm_ruby_version, '2.5.1@rails522'
set :deploy_to, "/home/deploy/fwp/staging"

set :branch, 'master'

role :app, %w{52.197.38.237}
role :web, %w{52.197.38.237}
role :db,  %w{52.197.38.237}

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

# https://stackoverflow.com/questions/20076645/capistrano-error-repository-not-found
set :ssh_options, forward_agent: false
# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# PUMA
# set :puma_state, "/home/deploy/pintuan-weapp/staging/shared/tmp/pids/puma.state"
# set :puma_pid,   "/home/deploy/pintuan-weapp/staging/shared/tmp/pids/puma.pid"
# set :puma_bind, "unix:///home/deploy/pintuan-weapp/staging/shared/tmp/sockets/puma.sock"      #根据nginx配置链接的sock进行设置，需要唯一
# set :puma_conf, "/home/deploy/pintuan-weapp/staging/shared/puma.rb"
# set :puma_access_log, "/home/deploy/pintuan-weapp/staging/shared/log/puma_error.log"
# set :puma_error_log, "/home/deploy/pintuan-weapp/staging/shared/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'staging'))
# set :puma_threads, [0, 16]
# set :puma_workers, 0
# set :puma_init_active_record, false
# set :puma_preload_app, false
