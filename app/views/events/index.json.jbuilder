json.array!(@events) do |event|
  json.extract! event, :id, :title, :detail, :event_type
  json.start event.start_date
  json.end event.end_date
  if event.event_type == "プライベート"
    json.className ["event-private"]
  elsif event.event_type == "イラスト投稿日"
    json.className ["event-post"]
  else
    json.className ["event-exhibition"]
  end
  json.url event_url(event, format: :html)
end