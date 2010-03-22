require 'rubygems'
require 'active_record'
require 'twitter'
require 'classes'

ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :socket => "/opt/local/var/run/mysql5/mysqld.sock",
      :database => "twirlybot_core",
      :username => "root",
      :password => ""
)

#Pattern::reset_table
#EventType::reset_table
#Event::reset_table
#IconType::reset_table
#Icon::reset_table
#User::reset_table

icon_type = IconType.new(:name=>'Feelings', :picture=>'', :url=>'')
icon_type.save

icon = Icon.new(:name=>'Heart', :picture=>'http://icons3.iconfinder.netdna-cdn.com/data/icons/c9d/favorites.png', :url=>'')
icon.icon_type_id = icon_type.id
icon.save

icon_2 = Icon.new(:name=>'Pitchfork', :picture=>'http://icons3.iconfinder.netdna-cdn.com/data/icons/c9d/favorites_delete.png', :url=>'')
icon_2.icon_type_id = icon_type.id
icon_2.save

event_type = EventType.new(:name=>'Like')
event_type.icon_id = icon.id
event_type.save

pattern = Pattern.new(:regex=>'/I love/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/I like/i')
pattern.event_type = event_type
pattern.save

event_type_2 = EventType.new(:name=>'Dislike')
event_type_2.icon_id = icon_2.id
event_type_2.save

pattern = Pattern.new(:regex=>'/I hate/i')
pattern.event_type = event_type_2
pattern.save

pattern = Pattern.new(:regex=>'/I don\'+t like/i')
pattern.event_type = event_type_2
pattern.save

event_type_2 = EventType.new(:name=>'Dislike')
event_type_2.icon_id = icon_2.id
event_type_2.save


icon_type = IconType.new(:name=>'Gowalla', :picture=>'http://gowalla.com/images/logo.png', :url=>'http://gowalla.com')
icon_type.save

event_type = EventType.new(:name=>'Gowalla Check In')
event_type.icon_type_id = icon_type.id
event_type.parse_method = <<-method
puts "Parsing Gowalla Checkin and Creating Icon"
Gowalla.configure do |config|
   config.api_key = 'c177a74888f646e7be3f1952c8994e6b'
end
gowalla = Gowalla::Client.new
spot = gowalla.spot(BaseGowalla.decode(capture[1]))
puts spot.image_url


icon = Icon.find_by_name(spot.name)
if !icon
  icon = Icon.new(:name=>spot.name, 
                  :picture=>spot.image_url, :url=>capture[0], 
                  :icon_type_id=>pattern.event_type.icon_type_id ) 
  icon.save
end

event_type = EventType.find_by_name(spot.name)
if !event_type
  event_type = EventType.new(:name=>spot.name, 
                             :icon_id => icon.id)
  event_type.save
end

event_type.id

method
event_type.save

pattern = Pattern.new(:regex=>'/http:\/\/gowal.la\/s\/([\w\n\/]+)/i')
pattern.event_type_id = event_type.id
pattern.save

user = User.new(:twitter_name=>'thirtysixthspan')
user.save

user = User.new(:twitter_name=>'blakecr')
user.save

user = User.new(:twitter_name=>'jonjonsiler')
user.save





