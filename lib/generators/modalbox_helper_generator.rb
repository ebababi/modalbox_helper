class ModalboxHelperGenerator < Rails::Generators::Base #:nodoc:
  source_root File.expand_path('../templates', __FILE__)

  desc "Creates helper resources in relevant public destinations."
  def create_resources
    copy_file 'spinner.gif', 'public/images/spinner.gif'
    create_file 'public/stylesheets/modalbox_helper.css' do
      source = File.expand_path(find_in_source_paths('modalbox.css'))

      File.read(source).tap do |content|
        content.gsub!(/url\(([^\)]+)\)/, 'url(../images/\1)')
        content.gsub!(/#MB_windowwrapper {([^}]+)\}/,
          "#MB_windowwrapper {\\1        z-index: 10001;\n}")
      end
    end
    create_file 'public/javascripts/modalbox_helper.js' do
      source = File.expand_path(find_in_source_paths('modalbox.js'))
      append = File.expand_path(find_in_source_paths('modalbox_helper.js'))

      "#{File.read(source)}\n\n#{File.read(append)}"
    end

    inject_into_class 'app/controllers/application_controller.rb', ApplicationController do
      "  helper :modalbox\n"
    end
  end
end
