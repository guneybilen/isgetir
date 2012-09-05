module SearchPlugin

  module SimpleSearch
    def simple_search(*fields)
      class_attribute :searchable_fields
      raise "Please specify the fields to search on" if fields.empty?
      self.searchable_fields = fields
      self.searchable_fields = self.searchable_fields.dup
    end
    def search(value)
# Initialize the conditions and values arrays
      conditions = []
# Build the conditions array from the parameters
      self.searchable_fields.each do |field|
        conditions << "#{self.table_name}.#{field.to_s} LIKE '%#{value}%'"
      end
      return self.where(conditions.join(' OR ')).limit(5)
    end
  end
end# SimpleSearch
