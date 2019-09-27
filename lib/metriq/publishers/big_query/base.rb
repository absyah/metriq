module Metriq
  module Publishers
    module BigQuery
      class Base
        require "google/cloud/bigquery"

        attr_reader(
          :dataset,
          :table,
          :data
        )

        def initialize(dataset, table, data)
          @dataset = dataset
          @table = table
          @data = data
        end

        def connect
          bigquery.dataset(dataset).table(table)
        end

        def bigquery
          Google::Cloud.bigquery(project_id)
        end

        def project_id
          ENV['GOOGLE_PROJECT_ID']
        end
      end
    end
  end
end
