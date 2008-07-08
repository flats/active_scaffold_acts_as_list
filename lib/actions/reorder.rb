module ActiveScaffold::Actions
  module Reorder
    def self.included(base)
      base.before_filter :reorder_authorized?, :only => [:move]
      base.before_filter :reorder_add_links, :only => [:index, :table, :update_table, :row] + ActiveScaffold::Config::Reorder::MOTION_METHODS.keys
    end

    attr_accessor :record_for_security_method

    protected
    def reorder_move
      @item = active_scaffold_config.model.find(params[:id])

      method = ActiveScaffold::Config::Reorder::MOTION_METHODS[params[:action]]
      @item.insert_at unless @item.in_list?
      @item.send(method)
      do_list
      render(:partial => 'reorder_move', :layout => false)
    end

    ActiveScaffold::Config::Reorder::MOTION_METHODS.keys.each do |key|
      alias_method key.to_sym, :reorder_move
      public key.to_sym
    end

    def reorder_add_links
      if reorder_enabled?
        %w{top up down bottom}.each do |motion|
          active_scaffold_config.action_links.add "reorder_#{motion}",
            :parameters => {:eval_label => "image_tag('active_scaffold/default/reorder_#{motion}.png', :size => '16x16', :alt => '#{motion.capitalize}', :title => '#{motion.capitalize}')"},
            :type => :record, :position => false, :method => :post
        end
      end
    end

    def reorder_enabled?
      active_scaffold_config.model.instance_methods.include? 'acts_as_list_class'
    end

    def reorder_authorized?
      authorized_for?(:action => :update)
    end
  end
end
