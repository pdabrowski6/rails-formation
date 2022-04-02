module RailsFormation
  module Formatters
    module Seeds
      class Row
        def initialize(config)
          @config = config
        end

        def to_s
          factory = "FactoryBot.create(:#{@config.fetch('factory_name')})"

          "#{@config.fetch('count')}.times { #{factory} }"
        end
      end
    end
  end
end
