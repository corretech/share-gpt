# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

common_table_names = %w(category ai_method)
common_table_names.each do |table_name|
    path = Rails.root.join("db", "seeds", "#{table_name}.rb")
    if File.exist?(path)
        puts "Creating #{table_name}...."
        require(path)
    end
end

table_names = %w(user chat )
table_names.each do |table_name|
    path = Rails.root.join("db", "seeds", Rails.env, "#{table_name}.rb")
    if File.exist?(path)
        puts "Creating #{table_name}...."
        require(path)
    end
end

