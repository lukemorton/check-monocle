module Monocle
  class Url
    module RSpecHelpers
      def radio_show_url(show)
        Url.new.radio_show_url(show)
      end
    end

    attr_reader :origin

    def initialize
      @origin = 'https://monocle.com'
    end

    def radio_show_url(show)
      "#{origin}/radio/shows/#{show}/"
    end
  end
end
