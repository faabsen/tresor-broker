class SearchController < ApplicationController
  resource_description do
    short 'Categories'
    full_description <<-END
The services contained in the Open Service Broker are described using the [SDL-NG framework](https://github.com/TU-Berlin-SNET/sdl-ng), please refer it to get information about the general syntax of the service descriptions. (currently not up-to-date!)

The services can be seperated into several categories, using the current vocabulary [on this page](/schema).

## Service categories
    END
  end

  respond_to :html, :xml, :json

  #before_filter :disable_pretty_printing, :only => [:new, :edit, :create]

  api :GET, 'search', 'Returns a list of services.'
  description <<-END

  END
  formats ['html']
  def search
    @services = Service.latest_with_status('approved')
    #TODO: just display the categories that are used -> db.sdl_base_type_services.distinct('service_categories.identifier')
    instances = compendium.type_instances

    @compendium = compendium

    #instances.each do |symbol, instance|
    #  puts instance.empty?
    #end
  end
end