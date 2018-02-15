# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://caten-church.herokuapp.com'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  add root_path, priority: 0.8
  add events_path, priority: 0.7, changefreq: 'daily'
  Event.in_registration_time.each do |event|
    add event_path(event), priority: 0.6, lastmod: event.updated_at
  end
  add about_path
  add term_path
  add contact_path

  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
