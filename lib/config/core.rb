module ActiveScaffold::Config
  class Core
    # configures where the active_scaffold_aal plugin itself is located. there is no instance version of this.
    cattr_accessor :aal_plugin_directory
    @@aal_plugin_directory = File.expand_path(__FILE__).match(/vendor\/plugins\/([^\/]*)/)[1]

    # the active_scaffold_aal template path
    def template_search_path_with_aal
      search_path = ["../../vendor/plugins/#{ActiveScaffold::Config::Core.aal_plugin_directory}/frontends/default/views"]
      search_path += self.template_search_path_without_aal
      return search_path
    end

    #class << self
    #  alias_method_chain :template_search_path, :aal
    #end
    alias_method_chain :template_search_path, :aal
  end
end

# Add the reorder action as a default action.  It will only be mixed in if the scaffolded model acts_as_list.
ActiveScaffold.set_defaults do |config|
  config.actions.add :reorder
end
