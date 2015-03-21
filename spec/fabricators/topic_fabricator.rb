Fabricator(:topic) do
  title { Faker::Lorem.word }
  description { Faker::Lorem.sentence }
end