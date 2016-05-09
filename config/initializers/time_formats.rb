Time::DATE_FORMATS[:display] = lambda {|date|
  seconds = (Time.now - date).round
  days    = seconds / (60 * 60 * 24); return date.strftime('%Y/%m/%d') if days > 0
  hours   = seconds / (60 * 60);      return "#{hours}時間前" if hours > 0
  minutes = seconds / 60;             return "#{minutes}分前" if minutes > 0
  return 'たった今'
}

Time::DATE_FORMATS[:full] = lambda do |date|
  return date.strftime('%Y/%m/%d %H:%M')
end
