json.array!(@proposals) do |proposal|
  json.extract! proposal, :id
  json.url proposal_url(proposal, format: :json)
end
