# Make sure that ActiveScaffold has already been included
ActiveScaffold rescue throw "should have included ActiveScaffold plug in first.  Please make sure that this overwrite plugging comes alphabetically after the ActiveScaffold plug in"

# Load our overrides
require "#{File.dirname(__FILE__)}/lib/config/core.rb" 
require "#{File.dirname(__FILE__)}/lib/config/reorder.rb" 
require "#{File.dirname(__FILE__)}/lib/actions/reorder.rb" 
require "#{File.dirname(__FILE__)}/lib/helpers/view_helpers.rb"

##
## Run the install script, too, just to make sure
##
require File.dirname(__FILE__) + '/install'
