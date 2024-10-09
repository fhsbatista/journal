require 'rake'

Rails.application.config.after_initialize do
  Rake.application.load_rakefile
  Rake::Task['db:mongoid:create_indexes'].invoke
end
