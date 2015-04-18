class CompareController < ApplicationController
  resource_description do
    short 'Comparison'
    full_description <<-END
The services contained in the Open Service Broker are described using the [SDL-NG framework](https://github.com/TU-Berlin-SNET/sdl-ng), please refer it to get information about the general syntax of the service descriptions. (currently not up-to-date!)
    END
  end

  respond_to :html, :xml, :json

  #before_filter :disable_pretty_printing, :only => [:new, :edit, :create]

  api :GET, 'compare', 'Service comparison'
  description <<-END

  END
  param :services, String, :desc => 'The services to compare to', :required => true

  formats ['html']
  error 404, 'Did not find specific the service(s)'
  def compare

    if params[:services]
      redirect_to :controller => 'compare', :action => 'show', :service1 => params[:services][0], :service2 => params[:services][1], :service3 => params[:services][2], :service4 => params[:services][3]
    else
      flash[:message] = t('compare.show.not_found')
      flash[:error] = t('compare.show.not_found_detail')

      redirect_to :controller => 'search', :action => 'search'
    end

  end

  api :GET, 'compare/:service1[/:service2[/:service3[/:service4]]]', 'Service comparison'
  description <<-END

  END
  param :service1, String, :desc => 'The first service name', :required => true
  param :service2, String, :desc => 'The second service name', :required => false
  param :service3, String, :desc => 'The third service name', :required => false
  param :service4, String, :desc => 'The fourth service name', :required => false

  formats ['html']
  error 404, 'Did not find specific service(s)'
  def show
    service_names = [params[:service1],params[:service2],params[:service3],params[:service4]].compact

    @services = Service.names(service_names).to_a
    @services_count = @services.count + 1

    @properties = Hash[]

    @services.each do |service|
      @properties.deep_merge!(service.property_values)
    end

    if @services.blank?
      flash[:message] = t('compare.show.not_found')
      flash[:error] = t('compare.show.not_found_detail')

      redirect_to :controller => 'search', :action => 'search'
    end
  end
end