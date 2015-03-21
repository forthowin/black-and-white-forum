Fabricator(:subject) do
  title { Faker::Lorem.word }
  body { Faker::Lorem.sentence }
end