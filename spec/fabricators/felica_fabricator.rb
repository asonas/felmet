Fabricator(:felica) do
  idm          SecureRandom.uuid
  activation   false
  activated_at nil
end

Fabricator(:activated_felica, from: :felica) do
  activation true
  activated_at Date.today
end
