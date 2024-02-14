# frozen_string_literal: true

require "helper"

class TestCleaner < JekyllUnitTest

  context "directory containing no files and non-empty directories" do
    setup do

      @site = fixture_site()
      @site.process

    end

    should "keep the parent directory" do
        # empty, but one "should" must be here
    end

  end
end
