Fabricator(:user) do
  felica
  name   "MyString"
  role   "general"
end

Fabricator(:user_with_activated_felica, from: :user) do
  felica { Fabricate(:activated_felica) }
  role   "general"
end
