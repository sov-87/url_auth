admin = User.create(name: 'admin')
guest = User.create(name: AUTH_CONSTANTS::USERS::GUEST)

all_urls = Url.create(name: 'Все ссылки', url_pattern: ".*", url_type: simple_url)
guest_urls = [
  Url.create(name: AUTH_CONSTANTS::URL_NAMES::ROOT, url_pattern: AUTH_CONSTANTS::URLS::ROOT, sorder: '1', url_type: menu_entry),]

admin_group = UserGroup.create(name: 'Полный доступ')
admin_group.urls << all_urls
admin_group.users << admin
admin_group.save

guest_group = UserGroup.create(name: 'Гостевой доступ')
guest_group.urls << guest_urls
guest_group.users << guest
guest_group.save