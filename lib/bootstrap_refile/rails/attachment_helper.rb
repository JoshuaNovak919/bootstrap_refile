module BootstrapRefile
  # Rails view helpers which aid in using Refile from views.
  module AttachmentHelper
    # Form builder extension
    module FormBuilder
      # @see BootstrapAttachmentHelper#attachment_field
      def bootstrap_attachment_field(method, options = {})
        self.multipart = true
        @template.bootstrap_attachment_field(@object_name, method, objectify_options(options))
      end
    end

    # Generates a form field which can be used with records which have
    # attachments. This will generate both a file field as well as a hidden
    # field which tracks the id of the file in the cache before it is
    # permanently stored.
    #
    # @param object_name                    The name of the object to generate a field for
    # @param method                         The name of the field
    # @param [Hash] options
    # @option options [Object] object       Set by the form builder, currently required for direct/presigned uploads to work.
    # @option options [Boolean] direct      If set to true, adds the appropriate data attributes for direct uploads with refile.js.
    # @option options [Boolean] presign     If set to true, adds the appropriate data attributes for presigned uploads with refile.js.
    # @return [ActiveSupport::SafeBuffer]   The generated form field
    def bootstrap_attachment_field(object_name, method, object:, **options)
      file_icons = {
        'default' => 'fa-file-o',
        'pdf' => 'fa-file-pdf-o',
        'xls' => 'fa-file-excel-o',
        'xlsx' => 'fa-file-excel-o',
        'csv' => 'fa-file-excel-o',
        'doc' => 'fa-file-word-o',
        'docx' => 'fa-file-word-o',
        'jpg' => 'fa-file-image-o',
        'jpeg' => 'fa-file-image-o',
        'png' => 'fa-file-image-o',
        'gif' => 'fa-file-image-o'
      }

      options[:remove_class] ||= 'btn-primary'
      options[:select_class] ||= 'btn-primary'
      options[:progress_class] ||= ''

      options[:data] ||= {}

      attachment_name = method.to_s.humanize

      file_exists = (!object["#{method}_id"].nil?)
      file_extension = (file_exists)? File.extname(object["#{method}_filename"].to_s).gsub(/\./, '') : ''
      file_name = (file_exists && !object["#{method}_filename"].to_s.blank?)? object["#{method}_filename"].to_s : 'No file selected'

      image_url = (file_exists)? attachment_url(object, method.to_sym, :fit, 300, 300) : "http://placehold.it/300x200&text=#{attachment_name}"
      image_tag = image_tag(image_url, class: 'preview img-responsive')

      remove_attachment = check_box(object_name, "remove_#{method}".to_sym, { class: 'btn btn-primary' })
      attacher = object.send(:"#{method}_attacher")
      options[:accept] = attacher.accept

      if options[:direct]
        host = options[:host] || Refile.host || request.base_url
        backend_name = Refile.backends.key(attacher.cache)

        url = ::File.join(host, main_app.refile_app_path, backend_name)
        options[:data].merge!(direct: true, as: "file", url: url)
      end

      if options[:presigned] and attacher.cache.respond_to?(:presign)
        options[:data].merge!(direct: true).merge!(attacher.cache.presign.as_json)
      end

      attachment_field = hidden_field(object_name, method, value: attacher.data.to_json, object: object, id: nil)
      attachment_field += file_field(object_name, method, options)

      attachment_icon = (file_exists && file_icons[file_extension])? file_icons[file_extension] : file_icons['default']

      result = <<-EOD
      <div class="refile-upload #{(file_exists)? 'filled' : ''} #{(!file_extension.blank?)? "filled-type-#{file_extension}" : ''}">
        <h4>#{attachment_name}</h4>
        <div class="row">
          <div class="col-sm-5">
            <span class="thumbnail">#{image_tag}</span>
          </div>
          <div class="col-sm-7">
            <div class="progress">
              <div class="progress-bar #{options[:progress_class]}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                <span class="sr-only">0% Complete</span>
              </div>
            </div>
            <div class="file-info"><i class="fa #{attachment_icon}"></i> #{file_name}</div>
            <span class="btn-group btn-remove" data-toggle="buttons">
              <label class="btn #{options[:remove_class]}">
                Remove #{attachment_name}
                #{remove_attachment}
              </label>
            </span>
            <span class="btn #{options[:select_class]} btn-file">
              Select #{attachment_name}
              #{attachment_field}
            </span>
          </div>
        </div>
      </div>
EOD
      return result.html_safe
    end
  end
end