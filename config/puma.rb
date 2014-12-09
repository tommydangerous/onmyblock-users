preload_app!

bind "tcp://0.0.0.0:#{ENV.fetch 'WEB_PORT', 3000}"
pidfile '/app/tmp/pids/puma.pid'
state_path '/app/tmp/pids/puma.state'
stdout_redirect '/app/log/puma.stdout.log', '/app/log/puma.stderr.log', true
workers ENV.fetch('WEB_CONCURRENCY', 2)
worker_timeout ENV.fetch('WEB_TIMEOUT', 60)
