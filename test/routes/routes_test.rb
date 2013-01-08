    require "minitest_helper"

    describe "Homepage Route Acceptance Test" do
      it "resolves the homepage" do
        assert_routing "/", :controller => "home", :action => "index"
      end
    end

    class HomepageRouteTest < MiniTest::Rails::ActionDispatch::IntegrationTest
      def test_homepage
        assert_routing "/", :controller => "home", :action => "index"
      end
    end
