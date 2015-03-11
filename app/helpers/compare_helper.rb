module CompareHelper
  def render_prop(property)
    if property.class < SDL::Types::SDLSimpleType
      render :partial => "value_#{property.class.to_s.demodulize.underscore}", :locals => {:value => property}
    elsif property.class < SDL::Base::Type
      if property.identifier
        property.documentation
      end
    #else
      #"I don't know, how to render #{property.class}."
    end
  end
end


