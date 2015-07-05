Fabricator(:felica) do
  idm          "test"
  activation   false
  activated_at nil
end

Fabricator(:activated_felica, from: :felica) do
  activation true
  activated_at Date.today
end
