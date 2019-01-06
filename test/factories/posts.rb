FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence(word_count = 5) }
    body { FFaker::Lorem.paragraphs(paragraph_count = 5) }
    description { FFaker::Lorem.paragraph(sentence_count = 10) }
    banner_image_url { "https://picsum.photos/600/400/?image=#{ FFaker::PhoneNumber.area_code}"}
  end
end
