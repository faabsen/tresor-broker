module CompareHelper
  def render_prop(value)
    if value.class < SDL::Types::SDLSimpleType
      render :partial => "value_#{value.class.to_s.demodulize.underscore}", :locals => {:value => value}
    elsif value.class < SDL::Base::Type
      if value.identifier
        value.documentation
      else
        '<table>' + render( :partial => 'services/properties', :locals => {:holder => value}) + '</table>'
      end
    #else
      #"I don't know, how to render #{property.class}."
    end
  end
end

