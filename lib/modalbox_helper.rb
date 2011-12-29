# = Modalbox Helper
module ModalboxHelper

  #
  # Returns a link of the given +name+ that will trigger the ModalBox JavaScript
  # library's function show using the onclick handler and return false after the
  # fact.
  #
  # The first argument +name+ is used as the link text.
  #
  # The next arguments are optional and may include the content context, a hash
  # of options and a hash of html_options.
  #
  # The +content+ argument can be omitted in favor of a block, which evaluates
  # to a string when the template is rendered.
  #
  # The +options+ will accept a hash of attributes passed as options to the show
  # function. Some examples are :title => “Preferences“, :width => 600 etc. You
  # may also pass an :escape boolean option to HTML escape the content. By
  # default this is false.
  #
  # The +html_options+ will accept a hash of html attributes for the link tag.
  # Some examples are :class => “nav_button“, :id => “articles_nav_button“ etc.
  #
  # Note: if you choose to specify the content in a block, but would like to
  # pass html_options, set the +options+ parameter to nil.
  #
  # ==== Examples
  # This creates a modal dialog for the content of a url:
  #   <%= link_to_modal 'Preferences', edit_user_registration_path %>
  def link_to_modal(name, *args, &block)
    if block_given?
      options      = args.first
      html_options = args.second || {}
      content = capture(&block)
    else
      content      = args[0]
      options      = args[1]
      html_options = args[2] || {}
    end

    data = options.delete(:escape) ? "data:#{html_escape(content)}" : content
    html_options['href'] = data || '#'
    html_options['data-modal'] = options.try(:to_json) || 'true'

    content_tag(:a, name, html_options)
  end
end
