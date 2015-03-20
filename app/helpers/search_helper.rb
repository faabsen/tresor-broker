module SearchHelper
  def render_value(property)
    if (property.type < SDL::Types::SDLSimpleType && property.type == SDL::Types::SDLBoolean)
      render :partial => "value_#{property.type.to_s.demodulize.underscore}", :locals => {:value => property}
    elsif property.type < SDL::Base::Type
      if value.identifier
        value.documentation
      else
        '<table>' + render( :partial => 'services/properties', :locals => {:holder => value}) + '</table>'
      end
    else
      "I don't know, how to render #{value.class}."
    end
  end
end