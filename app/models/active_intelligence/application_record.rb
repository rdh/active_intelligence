# frozen_string_literal: true

module ActiveIntelligence
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
