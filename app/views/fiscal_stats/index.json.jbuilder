json.array!(@fiscal_stats) do |fiscal_stat|
  json.extract! fiscal_stat, :id
  json.url fiscal_stat_url(fiscal_stat, format: :json)
end
