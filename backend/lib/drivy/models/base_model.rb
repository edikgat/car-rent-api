# frozen_string_literal: true

module Drivy
  class BaseModel
    ValidationError = Class.new(BaseError)

    PRESENCE_VALIDATION_ERROR_MESSAGE = "Can't be blank"
    POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE = 'Should be positive integer'
    DATE_ERROR_MESSAGE = 'Should be date'
    UNIQUE_ERROR_MESSAGE = 'Should be unique'

    class << self
      def create(args = {})
        new(args).tap do |instance|
          repository.push(instance)
        end
      end

      def repository
        repository_class.instance
      end

      def primary_key_name
        :id
      end

      def belongs_to(assiciation_name)
        assiciation_module = Module.new do
          define_method assiciation_name do
            self.class.model_class_for(assiciation_name).repository.find do |model|
              model.primary_key == public_send("#{assiciation_name}_id")
            end
          end
        end
        include(assiciation_module)
        assiciation_name
      end

      def model_class_for(assiciation_name)
        Object.const_get("Drivy::#{assiciation_name.to_s.capitalize}")
      end

      private

      def repository_class
        Object.const_get("#{name}sRepository")
      end
    end

    def repository
      self.class.repository
    end

    def primary_key
      public_send(self.class.primary_key_name)
    end

    def valid?
      raise NotImplementedError
    end

    private

    def validates_presence_of(key)
      value = value_for(key)

      raise_validation_error(key, PRESENCE_VALIDATION_ERROR_MESSAGE) if value.nil?
      raise_validation_error(key, PRESENCE_VALIDATION_ERROR_MESSAGE) if value.is_a?(Numeric) && value.zero?
      raise_validation_error(key, PRESENCE_VALIDATION_ERROR_MESSAGE) if value.is_a?(String) && value.size.zero?
      raise_validation_error(key, PRESENCE_VALIDATION_ERROR_MESSAGE) if value.is_a?(BaseModel) && value.primary_key.nil?
    end

    def validates_positive_integer_of(key)
      value = value_for(key)

      return if value.is_a?(Integer) && value.positive?

      raise_validation_error(key,
                             POSITIVE_INTEGER_VALIDATION_ERROR_MESSAGE)
    end

    def validates_date_of(key)
      raise_validation_error(key, DATE_ERROR_MESSAGE) unless value_for(key).is_a?(Date)
    end

    def validates_uniqueness_of(key)
      repository.any? { |model| model != self && model.public_send(key) == value_for(key) } &&
        raise_validation_error(key, UNIQUE_ERROR_MESSAGE)
    end

    def raise_validation_error(key, message)
      raise ValidationError, "#{self.class.name}: #{primary_key}, #{key}: #{message}"
    end

    def value_for(key)
      public_send(key)
    end
  end
end
