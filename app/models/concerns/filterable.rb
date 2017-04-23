module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.where("#{key} Like ? ", "%#{value}%") if value.present?
      end
      results
    end
  end
end
