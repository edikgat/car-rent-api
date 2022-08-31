# frozen_string_literal: true

require 'singleton'

module Drivy
  class BaseRepository
    include ::Enumerable
    include ::Singleton

    InvalidItemError = Class.new(BaseError)
    INVALID_ITEM_CLASS_ERROR_MESSAGE = 'Invalid Item Class'

    attr_reader :collection

    class << self
      def descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end

      def reset_all_subclasses!
        descendants.each do |subsclass|
          subsclass.instance.reset!
          subsclass.reset_all_subclasses!
        end
      end

      def all
        instance.entries
      end
    end

    def initialize
      @collection = []
    end

    def reset!
      @collection = []
    end

    def push(item)
      validate_push?(item)

      collection.push(item)
    end

    def each(&block)
      if block
        collection.each(&block)
      else
        to_enum(:each)
      end
    end

    private

    def validate_push?(item)
      raise InvalidItemError, INVALID_ITEM_CLASS_ERROR_MESSAGE unless item.is_a?(instance_class)

      item.valid?
    end

    def instance_class
      Object.const_get(self.class.name.chomp('sRepository'))
    end
  end
end
