namespace :truncate do
	desc "Will Truncate all Titles and Avails data"
  task :all => :environment do
  	ActiveRecord::Base.execute("truncate issues")
  end
end