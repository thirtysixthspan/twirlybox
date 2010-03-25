require 'rubygems'
require 'active_record'
require 'twitter'
require 'gowalla'
require 'base_n'

require '../app/models/icon'
require '../app/models/icon_type'
require '../app/models/item'
require '../app/models/item_type'
require '../app/models/event'
require '../app/models/event_type'
require '../app/models/pattern'
require '../app/models/user'

ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :socket => "/opt/local/var/run/mysql5/mysqld.sock",
      :database => "twirlybot_core",
      :username => "root",
      :password => ""
)

users = User.find(:all)
patterns = Pattern.find(:all)

begin
  httpauth = Twitter::HTTPAuth.new('twirlybot', '1twirlybox4u')
  base = Twitter::Base.new(httpauth)
rescue => e
  puts "The error message was this: #{e}"
  sleep 30*60
  next
end

users.each do |user|

  puts("Matching #{user.twitter_name}")

  begin
    search = base.user_timeline({:id => user.twitter_name, :count=>200})
    next unless search && search.size>0
  rescue => e
    puts "The error message was this: #{e}"
    sleep 5*60
    next
  end

  search.each do |tweet| 
    
    puts "\nEvaluating #{tweet.id} #{tweet.text}"
    patterns.each do |pattern|
      capture = tweet.text.match(eval(pattern.regex))
      if capture
        if !pattern.event_type.parse_method
          name = pattern.event_type.name
          puts("@#{user.twitter_name} #{name} - #{tweet.text}")
          puts tweet
          event = Event.new( :user_id => user.id, :event_type_id => pattern.event_type_id, :twitter_status_id => tweet.id )
          event.save
        else
          event_type_id = eval(pattern.event_type.parse_method)
          event = Event.new(:user_id => user.id, :event_type_id => event_type_id , :twitter_status_id => tweet.id)
          event.save
        end
      end
    end 
  end

  sleep 5
end
