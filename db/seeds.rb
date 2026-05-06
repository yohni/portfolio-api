# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  require "faker"

  ApplicationRecord.transaction do
    [ PostTag, Post, Tag, Experience, Project, Session, User ].each(&:delete_all)

    Faker::Lorem.unique.clear

    users = 4.times.map do |i|
      User.create!(
        email_address: "dev#{i + 1}@example.com",
        password: "password",
        password_confirmation: "password"
      )
    end

    tags = 10.times.map do
      base = "#{Faker::Lorem.unique.word}-#{rand(1000)}"
      name = base.titleize
      Tag.create!(name:, slug: base.parameterize)
    end

    users.each do |user|
      rand(2..4).times do
        start_date = Faker::Date.between(from: 8.years.ago, to: 3.years.ago)
        if [ true, false ].sample
          user.experiences.create!(
            company: Faker::Company.name,
            role: Faker::Job.title,
            description: Faker::Lorem.paragraph(sentence_count: 2),
            location: Faker::Address.city,
            start_date: start_date,
            current: false,
            end_date: Faker::Date.between(from: start_date + 180.days, to: start_date + 3.years),
            position: Faker::Number.between(from: 0, to: 10)
          )
        else
          user.experiences.create!(
            company: Faker::Company.name,
            role: Faker::Job.title,
            description: Faker::Lorem.paragraph(sentence_count: 2),
            location: Faker::Address.city,
            start_date: Faker::Date.between(from: 4.years.ago, to: 30.days.ago),
            current: true,
            end_date: nil,
            position: Faker::Number.between(from: 0, to: 10)
          )
        end
      end

      rand(3..6).times do
        user.projects.create!(
          title: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph(sentence_count: rand(2..5)),
          github_url: Faker::Internet.url(host: "github.com"),
          live_url: Faker::Internet.url(scheme: "https"),
          thumbnail_url: Faker::LoremFlickr.image,
          tech_stack: Faker::Lorem.words(number: rand(2..6)),
          featured: [ true, false, false ].sample,
          position: Faker::Number.between(from: 0, to: 20)
        )
      end

      rand(2..5).times do
        published = [ true, false ].sample
        post = user.posts.create!(
          title: Faker::Lorem.sentence(word_count: rand(4..8)).delete("."),
          content: Faker::Lorem.paragraphs(number: rand(2..6)).join("\n\n"),
          cover_image_url: [ Faker::LoremFlickr.image, nil ].sample,
          status: published ? "published" : "draft",
          published_at: published ? Faker::Time.between(from: 60.days.ago, to: Time.current) : nil,
          views_count: Faker::Number.between(from: 0, to: 5000)
        )
        post.tags << tags.sample(rand(1..4))
      end
    end
  end

  puts "Seeded #{User.count} users, #{Project.count} projects, #{Experience.count} experiences," \
       " #{Post.count} posts, #{Tag.count} tags (development only)."
end
