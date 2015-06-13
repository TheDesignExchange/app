require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  setup do
    @design_method = design_methods(:DarkHorse)
    @design_methods = [@design_method]
  end

  test "format_design_methods" do
    formatted_design_methods = format_design_methods(@design_methods)
    expected_fields = ["categories", "characteristic_groups", "characteristics"]

    # expect keys in the formatted list to contain the above fields
  end
end
