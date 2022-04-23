# frozen_string_literal: true

module RailsFormation
  module Formatters
    module Factories
      class Value
        MAPPINGS = {
          'first_name' => 'FFaker::Name.first_name',
          'last_name' => 'FFaker::Name.last_name',
          'zip_code' => 'FFaker::AddressUS.zip_code',
          'state' => 'FFaker::AddressUS.state',
          'city' => 'FFaker::Address.city',
          'street_name' => 'FFaker::Address.street_name',
          'building_number' => 'FFaker::Address.building_number',
          'country_code' => 'FFaker::Address.country_code',
          'country' => 'FFaker::Address.country',
          'time_zone' => 'FFaker::Address.time_zone',
          'plane_name' => 'FFaker::Airline.name',
          'flight_number' => 'FFaker::Airline.flight_number',
          'animal' => 'FFaker::AnimalUS.common_name',
          'iban' => 'FFaker::Bank.iban',
          'card_number' => 'FFaker::Bank.card_number',
          'card_type' => 'FFaker::Bank.card_number',
          'card_expiry_date' => 'FFaker::Bank.card_expiry_date',
          'book_title' => 'FFaker::Book.title',
          'book_genre' => 'FFaker::Book.genre',
          'book_author' => 'FFaker::Book.author',
          'book_isbn' => 'FFaker::Book.isbn',
          'boolean' => 'FFaker::Boolean.maybe',
          'color' => 'FFaker::Color.name',
          'color_hex_code' => 'FFaker::Color.hex_code',
          'company_name' => 'FFaker::Company.name',
          'position' => 'FFaker::Company.position',
          'currency_code' => 'FFaker::Currency.code',
          'currency_name' => 'FFaker::Currency.name',
          'currency_symbol' => 'FFaker::Currency.symbol',
          'education_degree' => 'FFaker::Education.degree',
          'school_name' => 'FFaker::Education.school_name',
          'ingredient' => 'FFaker::Food.ingredient',
          'vegetable' => 'FFaker::Food.vegetable',
          'fruit' => 'FFaker::Food.fruit',
          'meat' => 'FFaker::Food.meat',
          'game_title' => 'FFaker::Game.title',
          'game_category' => 'FFaker::Game.category',
          'gender_binary' => 'FFaker::Gender.binary',
          'gender_random' => 'FFaker::Gender.random',
          'latitude' => 'FFaker::Geolocation.lat',
          'longitude' => 'FFaker::Geolocation.lng',
          'email' => 'FFaker::Internet.email',
          'username' => 'FFaker::Internet.user_name',
          'domain' => 'FFaker::Internet.domain_name',
          'slug' => "FFaker::Internet.slug(nil, '-')",
          'job_title' => 'FFaker::Job.title',
          'locale' => 'FFaker::Locale.code',
          'language' => 'FFaker::Locale.language',
          'movie' => 'FFaker::Movie.title',
          'name' => 'FFaker::Name.name',
          'number' => 'FFaker::Number.number',
          'decimal' => 'FFaker::Number.decimal',
          'phone_number' => 'FFaker::PhoneNumber.phone_number',
          'brand_name' => 'FFaker::Product.brand',
          'product_name' => 'FFaker::Product.product_name',
          'tech_skill' => 'FFaker::Skill.tech_skill',
          'specialty' => 'FFaker::Skill.specialty',
          'sport_name' => 'FFaker::SportUS.name',
          'ssn' => 'FFaker::SSN.ssn',
          'month' => 'FFaker::Time.month',
          'datetime' => 'FFaker::Time.datetime',
          'date' => 'FFaker::Time.date'
        }.freeze

        def self.detect(specialized)
          MAPPINGS[specialized]
        end
      end
    end
  end
end
