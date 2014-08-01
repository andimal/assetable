class GalleryInput < SimpleForm::Inputs::FileInput

  include Assetable::Uploaders

  def input
    # TODO:: Find a better way to do this
    fieldname = "#{object_name}[#{attribute_name}_attributes][asset_attachments_attributes]"

    # This is the hidden input that identifies which gallery we are saving
    # otherwise it will create a new gallery each time.
    gallery_hidden_input = template.hidden_field_tag("#{object_name}[#{attribute_name}_attributes][id]", (object.send(attribute_name).present? ? object.send(attribute_name).id : ""))

    # This is the hidden inputs for the uploader. Each asset added to the
    # gallery will use this input name
    gallery_item_hidden_input = template.hidden_field_tag(fieldname, nil, class: "assetable-uploader-input")
    puts "gallery_item_hidden_input:: #{gallery_item_hidden_input}"

    gallery = object.send("#{attribute_name}")

    # Gallery preview
    # preview = gallery_preview(fieldname).html_safe rescue ""

    # # Uploader HTML = preview + hidden input
    # uploader_html = template.content_tag(:div, (gallery_hidden_input + preview), class: "uploader-assets-wrapper")

    # Create and return the uploader html
    # directions = options[:directions]

    # uploader_wrapper = template.content_tag :div, (uploader_html + hidden_input + directions_html(directions, attribute_name).html_safe), class: "gallery-uploader"

    return ac.send(:render_to_string, :partial => 'assetable/shared/templates/gallery', locals: {fieldname: fieldname, gallery: gallery, gallery_item_hidden_input: gallery_item_hidden_input, gallery_hidden_input: gallery_hidden_input, options: options})
    # return uploader_wrapper
  end

  def ac
    return @c if @c.present?
    @c = ActionController::Base.new
    @c.request = OpenStruct.new()
    @c
  end

end