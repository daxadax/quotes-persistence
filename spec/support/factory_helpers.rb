require 'json'

module Support
  module FactoryHelpers

    def build_serialized_quote(options = {})
      author  = options[:author]  || 'Author'
      title   = options[:title]   || 'Title'
      content = options[:content] || 'Content'

      {
        :author       => author,
        :title        => title,
        :content      => content,
        :uid          => options[:uid]         || nil,
        :publisher    => options[:publisher]    || nil,
        :year         => options[:year]         || nil,
        :page_number  => options[:page_number]  || nil,
        :tags         => build_tags(options),
        :links        => build_links(options)
      }
    end

    def build_serialized_user(options = {})
      {
        :uid        => options[:uid],
        :nickname   => options[:nickname]   ||'nickname',
        :email      => options[:email]      ||'email',
        :auth_key   => options[:auth_key]   ||'auth_key',
        :favorites  => options[:favorities] || [],
        :added      => options[:added]      || [],
        :terms_accepted => true
      }
    end

    private

    def build_tags(options)
      tags = options[:tags] || []

      return dump(tags) unless options[:no_json]
      tags
    end

    def build_links(options)
      links = options[:links] || []

      return dump(links) unless options[:no_json]
      links
    end

    def dump(obj)
      JSON.dump(obj)
    end

  end
end