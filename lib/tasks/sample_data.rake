namespace :db do
  desc "Fill db with sample data"
  task :populate => :environment do
    Blog.delete_all
    99.times do |n|
      name = Faker::Name.name
      url = "http://www.blog#{n+1}.com"
      Blog.create!(name: name, url: url)
    end
  end
end
