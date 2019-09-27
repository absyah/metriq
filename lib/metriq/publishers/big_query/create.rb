module Metriq
  module Publishers
    module BigQuery
      class Create < Publishers::BigQuery::Base
        def process
          response_handler connect.insert(data)
        end

        private

        def response_handler(response)
          if not response.success?
            raise Metriq::Error::PublisherError.new("#{response.error_count} : #{response.insert_errors}")
          end
        end
      end
    end
  end
end
