module SpreeAddressBook
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        append_file "vendor/assets/javascripts/spree/frontend/all.js", "//= require spree/frontend/spree_address_book\n"
      end

      def add_stylesheets
        inject_into_file "vendor/assets/stylesheets/spree/frontend/all.scss", " *= require spree/frontend/spree_address_book\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_address_book'
      end

      def run_migrations
         res = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask "Would you like to run the migrations now? [Y/n]")
         if res
           run 'bundle exec rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end

