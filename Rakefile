# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

LinkedInAggregator::Application.load_tasks

task network_worker: :environment do
  NetworkWorker.new()
end

task profile_worker: :environment do
  ProfileWorker.new()
end