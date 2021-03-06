module Halunke
  module Runtime
    class HNativeObject
      attr_reader :ruby_value

      def initialize(runtime_class, ruby_value = nil)
        @runtime_class = runtime_class
        @ruby_value = ruby_value
      end

      def receive_message(context, message_name, message_value)
        m = @runtime_class.lookup(message_name)
        m.receive_message(context, "call", [HArray.create_instance([self].concat(message_value))])
      end

      def inspect(context)
        receive_message(context, "inspect", []).ruby_value
      end
    end
  end
end
