class TestGridPosition < Test::Unit::TestCase
  
 # def initialize( *args)
  #  test_create_grid_position
   # test_valid_string_position
   # test_invalid_string_position
 # end

  def test_create_grid_position
    actual_position = GridPosition.new('A,1')
    assert_equal 0 , actual_position.row, "Positions not the same"
    assert_equal 0 , actual_position.col, "Positions not the same"
  end

  def test_valid_string_position
    assert_equal true, GridPosition.is_valid_position_string("C,2")
  end

  def test_invalid_string_position
     assert_equal false, GridPosition.is_valid_position_string("D,2")
  end

end
