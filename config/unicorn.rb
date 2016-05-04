# -*- coding: utf-8 -*-
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
preload_app true

listen "/tmp/unicorn.sock"
pid "/tmp/unicorn.pid"

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end

# logs
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
