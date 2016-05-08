module FetchEntry
  extend ActiveSupport::Concern

  def get_entry(url)
    unless url =~ URI::regexp
      raise
    end

    entry = Entry.where(:url => url).first_or_initialize

    unless entry.id
      require 'open-uri'
      response = open(URI.parse(url), 'User-Agent' => Settings.bot.ua, :allow_redirections => :all, :read_timeout => 5)

      unless response
        raise
      end

      unless url == response.base_uri.to_s
        return get_entry(response.base_uri.to_s)
      end

      document = Nokogiri::HTML(response.read)
      information = get_information(document)

      unless information[:url]
        information[:url] = url
      end

      unless url == information[:url]
        return get_entry(information[:url])
      end

      entry.title = information[:title]
      entry.description = information[:description]
      entry.image = information[:image]
      entry.save
    end

    entry
  end

  private
  def get_information(document)
    information = {}
    ogs = document.css('head > meta[property^="og:"]')

    ogs.each do |item|
      property = item.attributes['property']&.value
      property.slice!('og:')
      property&.strip!

      content = item.attributes['content']&.value
      content&.strip!

      information[property.to_sym] = content
    end

    if information[:title].blank?
      item = document.css('title')&.first
      if item
        text = item.text.strip
        information[:title] = text
      end

      if information[:title].blank?
        information[:title] = 'NO TITLE'
      end
    end

    if information[:description].blank?
      item = document.css('head > meta[name="description"]')&.first
      if item
        content = item.attributes['content']&.value
        content&.strip!
        information[:description] = content
      end
    end

    if information[:url].blank?
      item = document.css('head > link[rel="canonical"]')&.first
      if item
        content = item.attributes['href']&.value
        content&.strip!
        information[:url] = content
      end
    end

    information.delete_if{ |k, v| v.nil? }
    information
  end

end
