require File.dirname(__FILE__) + '/test_helper.rb'

class TestDimension < Test::Unit::TestCase

  context "Dimension" do
    context "initializing" do
      context "with two strings as arguments" do
        setup do
          @dimension = Qcontent::Dimension.new('400','300')
        end
        
        should "set width" do
          assert_equal 400, @dimension.width
        end
        
        should "set height" do
          assert_equal 300, @dimension.height
        end
      end
      
      context "with two integers as arguments" do
        setup do
          @dimension = Qcontent::Dimension.new(400,300)
        end
        
        should "set width" do
          assert_equal 400, @dimension.width
        end
        
        should "set height" do
          assert_equal 300, @dimension.height
        end
      end
      
      context "with an array" do
        setup do
          @dimension = Qcontent::Dimension.new(['400','300'])
        end
        
        should "set width" do
          assert_equal 400, @dimension.width
        end
        
        should "set height" do
          assert_equal 300, @dimension.height
        end
      end
      
      context "with a hash" do
        setup do
          @dimension = Qcontent::Dimension.new({:width => 400, :height => 300})
        end
        
        should "set width" do
          assert_equal 400, @dimension.width
        end
        
        should "set height" do
          assert_equal 300, @dimension.height
        end
      end
      
      context "with a single string" do
        setup do
          @dimension = Qcontent::Dimension.new('400')
        end
        
        should "set width" do
          assert_equal 400, @dimension.width
        end
        
        should "set height" do
          assert_equal nil, @dimension.height
        end
      end
      
    end
    
    context "#to_s" do
      should "join with and height" do
        @dimension = Qcontent::Dimension.new(['400','300'])
        assert_equal '400x300', @dimension.to_s
      end
    end
    
    context "#to_a" do
      should "return array with width, height" do
        @dimension = Qcontent::Dimension.new(['400','300'])
        assert_equal [400, 300], @dimension.to_a
      end
    end
  end
  
end