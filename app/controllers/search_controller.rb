class SearchController < ApplicationController
  resource_description do
    short 'Search services'
    full_description <<-END
The services contained in the Open Service Broker are described using the [SDL-NG framework](https://github.com/TU-Berlin-SNET/sdl-ng), please refer it to get information about the general syntax of the service descriptions. (currently not up-to-date!)

    END
  end

  respond_to :html, :xml, :json

  #before_filter :disable_pretty_printing, :only => [:new, :edit, :create]

  api :GET, 'search', 'Returns a list of services.'
  description <<-END

  END
  formats ['html']
  def search

    request.query_parameters.delete("utf8")

    @query = {}
    request.query_parameters.each do |key, value|
      @query.store("#{key}.identifier", {"$in" => value})
    end

    #TODO: move query to extra method -> Service.filter()
    @services = Service.latest_with_status('approved').where(@query)

    choices = compendium.type_instances.select { |key, value| key.to_s.match(/^choice\d+/) }


    @params = request.query_parameters
    @compendium = compendium

    #instances = compendium.type_instances
    #instances.each do |symbol, instance|
    #  puts instance.empty?
    #end
  end
end