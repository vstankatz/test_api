FactoryBot.define do
  factory :quote do
    # n.times do
    #   quote = Quote.create!(
        author { Faker::Book.author }
        content { Faker::Movie.quote }
      # )
    end
  end
# end
