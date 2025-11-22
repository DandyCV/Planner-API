# frozen_string_literal: true

# Helper classes used for verified doubles in specs
unless defined?(TestSerializerClass)
  class TestSerializerClass
    def initialize(_entity, _options = nil); end
  end
end

unless defined?(TestSerializerInstance)
  class TestSerializerInstance
    def to_json(*)
      raise NotImplementedError
    end
  end
end

unless defined?(SerializableObject)
  class SerializableObject
    def initialize(errors: [])
      @errors = errors
    end

    attr_reader :errors
  end
end

unless defined?(ErrorleObject)
  class ErrorleObject
    def initialize(path:, text:)
      @path = path
      @text = text
    end

    attr_reader :path, :text
  end
end

unless defined?(Session)
  class Session
    def login(*)
      raise NotImplementedError
    end
  end
end

unless defined?(OperationInstance)
  class OperationInstance
    def call(*)
      raise NotImplementedError
    end
  end
end

unless defined?(Context)
  class Context
    def initialize(data = nil)
      @data = data
    end

    attr_reader :data
  end
end

unless defined?(RefreshResult)
  class RefreshResult
    def success(*); end
    def failure(*); end
  end
end

unless defined?(DestroyResult)
  class DestroyResult
    def success(*); end
    def failure(*); end
  end
end
