# frozen_string_literal: true

module Legion
  module Extensions
    module CognitiveEcho
      class Client
        include Runners::CognitiveEcho

        def initialize(engine: nil)
          @default_engine = engine || Helpers::EchoEngine.new
        end
      end
    end
  end
end
