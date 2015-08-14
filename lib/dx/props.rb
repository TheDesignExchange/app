require 'hash_control'
require 'yaml'

module Dx
  module Props
    def self.load_file(fname)
      require 'yaml'
      data = YAML.load_file(fname)
      Group.parse(type: :group, title: nil, contents: data).contents
    end

    TYPES = {}

    module YamlSupport
      ITEM_STYLE = Psych::Nodes::Mapping::FLOW
      GROUP_STYLE = Psych::Nodes::Mapping::BLOCK

      def self.included(base)
        base.extend ClassMethods
        base.yaml_style ITEM_STYLE
      end

      module ClassMethods
        attr_reader :_yaml_key_order, :_yaml_type, :_yaml_style

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

        def yaml_style(style)
          @_yaml_style = style
        end

        def parse(data)
          # puts "=> #{name}.parse"
          new(data)
        end
      end

      def encode_with(coder)
        # puts "=> #{self.class.name}.encode_with"
        coder.tag = nil
        coder.style = self.class._yaml_style
        present_ordered_keys.each { |key| coder[key.to_s] = @hash[key] }
      end

      private

      def present_ordered_keys
        present_keys = @hash.keys.map(&:to_sym)
        ordered_keys = self.class._yaml_key_order || YAML_KEY_ORDER
        ordered_keys -= (ordered_keys - present_keys)
        ordered_keys += (present_keys - ordered_keys)
        ordered_keys
      end
    end

    YAML_KEY_ORDER = :type, :title, :noun, :source, :icon, :icon0, :icon1, :contents

    class Group
      include ::HashControl::Model
      include YamlSupport
      yaml_type :group
      require_key :type, :contents, :title
      yaml_style GROUP_STYLE

      def self.parse(data)
        # puts "=> #{name}.parse"
        group = new(data)
        group.contents.map! do |item|
          TYPES[item[:type].to_sym].parse(item)
        end
        group
      end
    end

    class Numeric
      include ::HashControl::Model
      include YamlSupport
      yaml_type :numeric
      require_key :type, :source, :icon
      permit_key :noun, :noun_source  # TODO: change to require_one_of
    end

    class Tags
      include ::HashControl::Model
      include YamlSupport
      yaml_type :tags
      require_key :type, :noun, :source
      permit_key :icon
    end

    class Text
      include ::HashControl::Model
      include YamlSupport
      yaml_type :text
      require_key :type, :source, :title
      permit_key :icon
    end

    class Link
      include ::HashControl::Model
      include YamlSupport
      yaml_type :link
      require_key :type, :source, :title
      permit_key :icon
    end

    class Boolean
      include ::HashControl::Model
      include YamlSupport
      yaml_type :boolean
      require_key :type, :source, :title, :icon0, :icon1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  case (command = ARGV.shift)
  when "parse"
    ARGV.each do |arg|
      puts((Dx::Props.load_file arg).to_yaml(line_width: 1000))
    end
  when "normalize"
    ARGV.each do |arg|
      contents = (Dx::Props.load_file arg).to_yaml(line_width: 1000)
      File.open(arg, 'w') { |f| f.write contents }
    end
  # when "test-props"
  #   require 'yaml'
  #   puts(Props::Text.new(
  #     icon: "pencil", noun: "Development Cycle",
  #     source: "development_cycle", type: "text"
  #   ).to_yaml)
  # when "test-yamlsupport"
  #   class Test
  #     include ::HashControl::Model
  #     include Props::YamlSupport
  #     require_key :a, :b, :c
  #     permit_key :d, :e
  #     yaml_key_order :a, :d, :e
  #   end
  #   puts(Test.new(a: 1, b: 2, c: 3, d: 4).to_yaml)
  #   puts(Test.new(c: 1, a: 3, b: 5, e: nil).to_yaml)
  #
  #   Props::DATA[0] = 1
  #   puts Props::DATA
  else
    puts "Invalid command: #{command}"
    exit 1
  end
end
