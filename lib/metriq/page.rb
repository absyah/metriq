module Metriq
  class Page
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

    def publish
      Publishers::BigQuery::Create.new(dataset, table, data).process
    end

    def self.read(key)
      Draft::Utils.new(key).read
    end

    def self.draft(key, data)
      Draft::Utils.new(key).write(data)
    end

    def self.clear(key)
      Draft::Utils.new(key).clear
    end
  end
end
