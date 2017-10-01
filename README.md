# CatenChurch
本專案為茄典教會網站，網址是<https://caten-church.herokuapp.com/>

專案的架構為 `rails 5.0.1` + `postgres 9.5.4.1` + `Heroku` + `newrelic`  

- 前台
  - 帳號管理
  - 活動一覽
    - 報名活動
  - 公告一覽
  - 聯絡我們
- 後台管理員
  - 會員管理
  - 活動管理
  - 公告管理
  - 聯絡管理


## Rails

### sitemap

add below line in Gemfile

```ruby
gem 'sitemap_generator'
```

usage

```bash
# init config/sitemap.rb
$ rake sitemap:install
# generate public/sitmap.xml.gz
$ rake sitemap:refresh
```

add sitemap in public/robots.txt

```txt
sitemap: caten-church.herokuapp.com/sitemap.xml.gz
```

### Reset counter cache

如果counter cache出錯了，則進入rails console用此方法重整

```ruby
# 例如想重整 event.id = 15 的 participants_count
Event.reset_counters 15, :participants
```

或使用 lib/tasks/counter_cache.rake 重整

```bash
$ rake counter_cache:reset_all
```

## Heroku

部署指令

```bash
$ git push heroku master
$ heroku run rake db:migrate
$ figaro heroku:set -e production
```

查看heroku環境變數

```bash
$ heroku config
```

備份 db 到本地的 local_db_name

```bash
$ heroku pg:pull DATABASE_URL localDbName --app caten-church
```

### heroku app 加上 newrelic

參考 <https://docs.newrelic.com/docs/agents/ruby-agent/installation/install-new-relic-ruby-agent#Installing_the_Gem>

## Linux

### 檢查port被哪個行程佔用

例如 port 3000

```bash
# 列出 port 3000 的行程
$ lsof -i:3000
# 列出 port 3000 行程的 pid
$ lsof -t -i:3000
# 透過 pid 清除行程
$ kill $(lsof -t -i:3000)
# or 使用 -9 option
$ kill -9 $(lsof -t -i:3000)
```
