require 'hash_control'

module Dx
  module ModelProps
    def self.load_file(fname)
      require 'yaml'
      data = YAML.load_file(fname)
      Group.parse(type: 'group', title: nil, contents: data).contents
    end

    TYPES = {}

    module YamlSupport
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        attr_reader :_yaml_key_order, :_yaml_type

        def yaml_key_order(*key_order)
          key_order.each do |key|
            raise "Expected symbols, got #{key_order.inspect}" unless key.is_a? Symbol
          end
          @_yaml_key_order = [:type] + key_order
        end

        def yaml_type(type)
          raise "Expected symbol, got #{type.inspect}" unless type.is_a? Symbol
          @_yaml_type = type
          TYPES[type] = self
        end

        def parse(data)
          results = new(data)
          results
        end
      end

      def initialize(data)
        super(data)
        post_parse if respond_to? :post_parse
      end

      def ensure_ordered
        keys_in_order.each { |key| @hash[key] = @hash.delete(key) }
      end

      def encode_with(coder)
        repr = {}
        keys_in_order.each { |key| repr[key.to_s] = self[key] }
        coder.represent_map nil, repr
      end

      private

      def keys_in_order(ordered_keys = nil)
        ordered_keys ||= self.class._yaml_key_order
        present_keys = @hash.keys.map(&:to_sym)
        if present_keys != ordered_keys
          ordered_keys -= (ordered_keys - present_keys)
          ordered_keys += (present_keys - ordered_keys)
        end
        ordered_keys
      end
    end

    YAML_KEY_ORDER = [
      :type,
      :title, :noun,
      :source,
      :icon, :icon0, :icon1,
      :contents
    ]

    class Group
      include ::HashControl::Model
      include YamlSupport
      yaml_type :group
      require_key :type, :contents
      require_key :title
      yaml_key_order(*YAML_KEY_ORDER)

      def post_parse
        contents.map! { |item| TYPES[item[:type].to_sym].parse(item) }
      end
    end

    class Numeric
      include ::HashControl::Model
      include YamlSupport
      yaml_type :numeric
      require_key :type, :source, :noun, :icon
      yaml_key_order(*YAML_KEY_ORDER)
    end

    class Tags
      include ::HashControl::Model
      include YamlSupport
      yaml_type :tags
      require_key :type, :source
      permit_key :icon
      yaml_key_order(*YAML_KEY_ORDER)
    end

    class Text
      include ::HashControl::Model
      include YamlSupport
      yaml_type :text
      require_key :type, :source, :title, :icon
      yaml_key_order(*YAML_KEY_ORDER)
    end

    class Boolean
      include ::HashControl::Model
      include YamlSupport
      yaml_type :boolean
      require_key :type, :source, :title, :icon0, :icon1
      yaml_key_order(*YAML_KEY_ORDER)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  case (subcommand = ARGV.shift)
  when 'parse'
    ARGV.each { |fname| puts(ModelProps.load_file(fname).to_yaml) }
  when 'norm', 'normalize'
    ARGV.each do |fname|
      print "#{fname}..."
      $stdout.flush
      normalized = ModelProps.load_file(fname).to_yaml
      File.open(fname, 'w') { |file| file.write(normalized) }
      puts "done."
    end
  else
    puts "Unknown command: #{subcommand}"
    exit 1
  end
end
