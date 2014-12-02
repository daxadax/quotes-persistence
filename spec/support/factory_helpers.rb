require 'json'

module Support
  module FactoryHelpers

    def build_serialized_quote(options = {})
      added_by = options[:added_by] || 23
      content = options[:content] || 'Content'
      publication_uid = options[:publication_uid] || 99

      {
        :uid => options[:uid] || nil,
        :added_by => added_by,
        :content => content,
        :publication_uid => publication_uid,
        :page_number => options[:page_number]  || nil,
        :tags => build_tags(options),
        :links => build_links(options)
      }
    end

    def build_serialized_publication(uid, options = {})
      {
        :publication_uid => uid,
        :publication_added_by => options[:added_by] || 23,
        :author => options[:author] || "Author",
        :title => options[:title] || "Title",
        :publisher => options[:publisher] || "Publisher",
        :year => options[:year] || 1999
      }
    end

    def build_serialized_user(options = {})
      {
        :uid => options[:uid],
        :nickname => options[:nickname] ||'nickname',
        :email => options[:email] ||'email',
        :auth_key => options[:auth_key] ||'auth_key',
        :favorites => build_favorites(options),
        :added_quotes => build_added_quotes(options),
        :added_publications => build_added_publications(options),
        :terms => false
      }
    end

    private

    def build_favorites(options)
      favorites = options[:favorities] || [23, 999]

      return dump(favorites) unless options[:no_json]
      favorites
    end

    def build_added_publications(options)
        added = options[:added_publications] || []

        return dump(added) unless options[:no_json]
        added
    end

    def build_added_quotes(options)
      added = options[:added_quotes] || []

      return dump(added) unless options[:no_json]
      added
    end

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
