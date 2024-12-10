# frozen_string_literal: true

require "helper"

class TestCleaner < JekyllUnitTest

  should "sh1" do
      @site = fixture_site()
      @site.process
  end

end
