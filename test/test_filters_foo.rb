# frozen_string_literal: true

require "helper"

class TestFilters < JekyllUnitTest
  class JekyllFilter
    include Jekyll::Filters
    attr_accessor :site, :context

    def initialize(opts = {})
      @site = Jekyll::Site.new(opts.merge("skip_config_files" => true))
      @context = Liquid::Context.new(@site.site_payload, {}, :site => @site)
    end
  end

  def make_filter_mock(opts = {})
    JekyllFilter.new(site_configuration(opts)).tap do |f|
      tz = f.site.config["timezone"]
      Jekyll.set_timezone(tz) if tz
    end
  end

  context "filters" do
    setup do
      @sample_time = Time.utc(2013, 3, 27, 11, 22, 33)
      @timezone_before_test = ENV["TZ"]
      @filter = make_filter_mock(
        "timezone"               => "UTC",
        "url"                    => "http://example.com",
        "baseurl"                => "/base",
        "dont_show_posts_before" => @sample_time
      )
      @sample_date = Date.parse("2013-03-02")
      @time_as_string = "September 11, 2001 12:46:30 -0000"
      @time_as_numeric = 1_399_680_607
      @integer_as_string = "142857"
      @array_of_objects = [
        { "color" => "teal", "size" => "large"  },
        { "color" => "red",  "size" => "large"  },
        { "color" => "red",  "size" => "medium" },
        { "color" => "blue", "size" => "medium" },
      ]
    end

    teardown do
      ENV["TZ"] = @timezone_before_test
    end

    context "jsonify filter" do

      should "convert drop to json" do
        @filter.site.read
        expected = {
          "name"          => "2008-02-02-published.markdown",
          "path"          => "_posts/2008-02-02-published.markdown",
          "previous"      => nil,
          "output"        => nil,
          "content"       => "This should be published.\n",
          "id"            => "/publish_test/2008/02/02/published",
          "url"           => "/publish_test/2008/02/02/published.html",
          "relative_path" => "_posts/2008-02-02-published.markdown",
          "collection"    => "posts",
          "excerpt"       => "<p>This should be published.</p>\n",
          "draft"         => false,
          "categories"    => [
            "publish_test",
          ],
          "layout"        => "default",
          "title"         => "Publish",
          "category"      => "publish_test",
          "date"          => "2008-02-02 00:00:00 +0000",
          "slug"          => "published",
          "ext"           => ".markdown",
          "tags"          => [],
        }
        actual = JSON.parse(@filter.jsonify(@filter.site.docs_to_write.first.to_liquid))

        next_doc = actual.delete("next")
        refute_nil next_doc
        assert next_doc.is_a?(Hash), "doc.next should be an object"

        assert_equal expected, actual
      end
    end
  end
end
