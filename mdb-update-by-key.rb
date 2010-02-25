require 'rubygems'
require 'mongo'

db = Mongo::Connection.new.db("test")
things = db["news"]

if ARGV.size == 2
	record_count = ARGV[0].to_i
	times_to_update = ARGV[1].to_i
elsif
	record_count = 110 * 100 * 100
	times_to_update = 100 * 100 * 100
end

start_time = Time.now.to_i
update_count = 0

times_to_update.times do

	id = rand(record_count) + 1
    create_time = Time.now
	title = "This is title of news #{id} - updated at #{create_time}"
    source = "source of news #{id} - updated at #{create_time}"
    source_url = "http://www.cnblogs.com/JeffreyZhao/ - updated at #{create_time}"
    status = rand(5)
	
	things.update(
		{ "_id" => id }, 
		{
			"CreateTime" => create_time.to_i,
			"Title" => title,
			"Source" => source,
			"SourceUrl" => source_url,
			"Status" => status
		})
	
	update_count = update_count + 1
	if (update_count % 100000 == 0)
		end_time = Time.now.to_i
		puts "#{update_count} updates: #{end_time - start_time} seconds"
	end	
end