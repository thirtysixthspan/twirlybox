require 'rubygems'
require 'active_record'
require 'twitter'

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
#      :socket => "/tmp/mysql.sock",
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


icon_type = IconType.new(:name=>'Drinks', :picture=>'', :url=>'')
icon_type.save

coffee = Icon.new(:name=>'Coffee', :picture=>'/images/coffee.png', :url=>'', :icon_type_id=>icon_type.id)
coffee.save

event_type = EventType.new(:name=>'Coffee')
event_type.icon_id = coffee.id
event_type.parse_method = <<-method
puts "Coffee"

coffee_type = ItemType.find_by_name("coffee")
item = Item.new(:user_id=>user.id, :item_type_id=>coffee_type.id)
item.save

method
event_type.save

pattern = Pattern.new(:regex=>'/beer/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Sam Adams/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Bud Light/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/COOP/i')
pattern.event_type_id = event_type.id
pattern.save



beer = Icon.new(:name=>'Beer', :picture=>'/images/pint.png', :url=>'', :icon_type_id=>icon_type.id)
beer.save

event_type = EventType.new(:name=>'Beer')
event_type.icon_id = beer.id
event_type.parse_method = <<-method
puts "Beer"

beer_type = ItemType.find_by_name("beer")
item = Item.new(:user_id=>user.id, :item_type_id=>beer_type.id)
item.save

method
event_type.save

pattern = Pattern.new(:regex=>'/beer/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Sam Adams/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Bud Light/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/COOP/i')
pattern.event_type_id = event_type.id
pattern.save



tea = Icon.new(:name=>'Tea', :picture=>'/images/tea.png', :url=>'', :icon_type_id=>icon_type.id)
tea.save

event_type = EventType.new(:name=>'Tea')
event_type.icon_id = tea.id
event_type.parse_method = <<-method
puts "Tea"

tea_type = ItemType.find_by_name("tea")
item = Item.new(:user_id=>user.id, :item_type_id=>tea_type.id)
item.save

method
event_type.save

pattern = Pattern.new(:regex=>'/ tea /i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Tazo/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Lipton/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Arizona Ice/i')
pattern.event_type_id = event_type.id
pattern.save

juice = Icon.new(:name=>'Juice', :picture=>'/images/juice.png', :url=>'', :icon_type_id=>icon_type.id)
juice.save

event_type = EventType.new(:name=>'Juice')
event_type.icon_id = juice.id
event_type.parse_method = <<-method
puts "Beer"

juice_type = ItemType.find_by_name("juice")
item = Item.new(:user_id=>user.id, :item_type_id=>juice_type.id)
item.save

method
event_type.save

pattern = Pattern.new(:regex=>'/juice/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/OJ/')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Tropicana/')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/Simpy Orange/')
pattern.event_type_id = event_type.id
pattern.save




soda = Icon.new(:name=>'Soda', :picture=>'/images/soda.png', :url=>'', :icon_type_id=>icon_type.id)
soda.save

event_type = EventType.new(:name=>'Soda')
event_type.icon_id = soda.id
event_type.parse_method = <<-method
puts "Soda"

soda_type = ItemType.find_by_name("soda")
item = Item.new(:user_id=>user.id, :item_type_id=>soda_type.id)
item.save

method
event_type.save

pattern = Pattern.new(:regex=>'/soda/i')
pattern.event_type_id = event_type.id
pattern.save

pattern = Pattern.new(:regex=>'/ pop /i')
pattern.event_type_id = event_type.id
pattern.save





icon_type = IconType.new(:name=>'Emoticons', :picture=>'', :url=>'')
icon_type.save

bored = Icon.new(:name=>'bored', :picture=>'/images/bored.png', :url=>'', :icon_type_id=>icon_type.id)
bored.save

event_type = EventType.new(:name=>'Bored')
event_type.icon_id = bored.id
event_type.save

pattern = Pattern.new(:regex=>'/bored/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/ugg+/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/ meh /i')
pattern.event_type = event_type
pattern.save


cry = Icon.new(:name=>'cry', :picture=>'/images/cry.png', :url=>'', :icon_type_id=>icon_type.id)
cry.save

event_type = EventType.new(:name=>'Cry')
event_type.icon_id = cry.id
event_type.save

pattern = Pattern.new(:regex=>'/\:\'\(/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/waah/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/tears/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/crying/i')
pattern.event_type = event_type
pattern.save


elated = Icon.new(:name=>'elated', :picture=>'/images/elated.png', :url=>'', :icon_type_id=>icon_type.id)
elated.save

event_type = EventType.new(:name=>'Elated')
event_type.icon_id = elated.id
event_type.save

pattern = Pattern.new(:regex=>'/\:D/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/awesome/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/cool/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/excited/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/joyful/i')
pattern.event_type = event_type
pattern.save


happy = Icon.new(:name=>'happy', :picture=>'/images/happy.png', :url=>'', :icon_type_id=>icon_type.id)
happy.save

event_type = EventType.new(:name=>'Happy')
event_type.icon_id = happy.id
event_type.save

pattern = Pattern.new(:regex=>'/\:\)/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/happy/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/I\'+m happy/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/blessed/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/cheer/i')
pattern.event_type = event_type
pattern.save



sad = Icon.new(:name=>'sad', :picture=>'/images/sad.png', :url=>'', :icon_type_id=>icon_type.id)
sad.save

event_type = EventType.new(:name=>'Sad')
event_type.icon_id = sad.id
event_type.save

pattern = Pattern.new(:regex=>'/\:\(/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/sorry/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/\ssad\s/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/sucks/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/awful/i')
pattern.event_type = event_type
pattern.save


sassy = Icon.new(:name=>'sassy', :picture=>'/images/sassy.png', :url=>'', :icon_type_id=>icon_type.id)
sassy.save

event_type = EventType.new(:name=>'Sassy')
event_type.icon_id = sassy.id
event_type.save

pattern = Pattern.new(:regex=>'/\:p/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/sassy/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/cheeky/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/playful/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/blow a raspberry/i')
pattern.event_type = event_type
pattern.save


sleepy = Icon.new(:name=>'sleepy', :picture=>'/images/sleepy.png', :url=>'', :icon_type_id=>icon_type.id)
sleepy.save

event_type = EventType.new(:name=>'Sleepy')
event_type.icon_id = sleepy.id
event_type.save

pattern = Pattern.new(:regex=>'/zzz+/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/sleepy/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/tired/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/no sleep/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/asleep/i')
pattern.event_type = event_type
pattern.save


surprised = Icon.new(:name=>'surprised', :picture=>'/images/surprised.png', :url=>'', :icon_type_id=>icon_type.id)
surprised.save

event_type = EventType.new(:name=>'Surprised')
event_type.icon_id = surprised.id
event_type.save

pattern = Pattern.new(:regex=>'/o\_O/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/shock/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/surprised/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/ awe /i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/ wow /i')
pattern.event_type = event_type
pattern.save


wink = Icon.new(:name=>'wink', :picture=>'/images/wink.png', :url=>'', :icon_type_id=>icon_type.id)
wink.save

event_type = EventType.new(:name=>'Wink')
event_type.icon_id = wink.id
event_type.save

pattern = Pattern.new(:regex=>'/\;\)/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/\;D/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/\;p/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/wink/i')
pattern.event_type = event_type
pattern.save


icon_type = IconType.new(:name=>'Badges', :picture=>'', :url=>'')
icon_type.save

tu = Icon.new(:name=>'thumbs up', :picture=>'/images/thumbsup.png', :url=>'', :icon_type_id=>icon_type.id)
tu.save

event_type = EventType.new(:name=>'Positive')
event_type.icon_id = tu.id
event_type.save

pattern = Pattern.new(:regex=>'/good job/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/rock on/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/approved/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/well done/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/nice work/i')
pattern.event_type = event_type
pattern.save

nb = Icon.new(:name=>'Geeky', :picture=>'/images/geeky.png', :url=>'', :icon_type_id=>icon_type.id)
nb.save

event_type = EventType.new(:name=>'Geeky')
event_type.icon_id = nb.id
event_type.save

pattern = Pattern.new(:regex=>'/PHP/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/CSS/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/HTML5/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/PAGE RANK/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/google buzz/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/TWiT/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/Wired/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/Ruby on Rails/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/Python/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/Rails/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/iPad/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/OpenBeta/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/SDK/')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/API/')
pattern.event_type = event_type
pattern.save

bully = Icon.new(:name=>'bully', :picture=>'/images/bully.png', :url=>'', :icon_type_id=>icon_type.id)
bully.save

event_type = EventType.new(:name=>'Negative')
event_type.icon_id = bully.id
event_type.save

pattern = Pattern.new(:regex=>'/screw you/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/you dork/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/fuck/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/dumb ass/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/ass face/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/fucker/i')
pattern.event_type = event_type
pattern.save

pattern = Pattern.new(:regex=>'/douche/i')
pattern.event_type = event_type
pattern.save


user = User.new(:twitter_name=>'thirtysixthspan')
user.save

coffee_type = ItemType.new(:name=>"coffee", :price=>200, :icon_id=>coffee.id)
coffee_type.save

item = Item.new(:user_id=>user.id, :item_type_id=>coffee_type.id)
item.save

beer_type = ItemType.new(:name=>"beer", :price=>200, :icon_id=>beer.id)
beer_type.save

item = Item.new(:user_id=>user.id, :item_type_id=>beer_type.id)
item.save

tea_type = ItemType.new(:name=>"tea", :price=>200, :icon_id=>tea.id)
tea_type.save

juice_type = ItemType.new(:name=>"juice", :price=>200, :icon_id=>juice.id)
juice_type.save

soda_type = ItemType.new(:name=>"soda", :price=>200, :icon_id=>soda.id)
soda_type.save




item = Item.new(:user_id=>user.id, :item_type_id=>tea_type.id)
item.save

user = User.new(:twitter_name=>'ultimatecoder')
user.save

item = Item.new(:user_id=>user.id, :item_type_id=>beer_type.id)
item.save

user = User.new(:twitter_name=>'blakecr')
user.save

item = Item.new(:user_id=>user.id, :item_type_id=>tea_type.id)
item.save

user = User.new(:twitter_name=>'jonjonsiler')
user.save

item = Item.new(:user_id=>user.id, :item_type_id=>tea_type.id)
item.save

user = User.new(:twitter_name=>'loslosbaby')
user.save

item = Item.new(:user_id=>user.id, :item_type_id=>tea_type.id)
item.save




