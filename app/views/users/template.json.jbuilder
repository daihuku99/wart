json.array!(@events) do |event|
  json.extract! event, :id, :title, :detail, :event_type
  json.start event.start_date
  json.end event.end_date
  json.url event_url(event, format: :html)
end