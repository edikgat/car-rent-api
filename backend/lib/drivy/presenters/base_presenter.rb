# frozen_string_literal: true

module Drivy
  class BasePresenter
    def self.represent_for(object)
      raise NotImplementedError
    end

    private_class_method :new
  end
end
