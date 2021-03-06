class TeleFonica
  module Compute
    module Formats
      SUMMARY = {
        'id'    => String,
        'name'  => String,
        'links'  => Array
      }
    end
  end
end

def get_flavor_ref
  ENV['TELEFONICA_FLAVOR_REF'] || Fog::Compute[:telefonica].list_flavors.body['flavors'].first['id']
end

def get_image_ref
  ENV['TELEFONICA_IMAGE_REF'] || Fog::Compute[:telefonica].list_images.body['images'].first['id']
end

def get_volume_ref
  ENV['TELEFONICA_VOLUME_REF'] || Fog::Compute[:telefonica].list_volumes.body['volumes'].first['id']
end

def get_flavor_ref_resize
  # by default we simply add one to the default flavor ref
  ENV['TELEFONICA_FLAVOR_REF_RESIZE'] || (get_flavor_ref.to_i + 1).to_s
end

def set_password_enabled
  pw_enabled = ENV['TELEFONICA_SET_PASSWORD_ENABLED'] || "true"
  return pw_enabled == "true"
end

def get_security_group_ref
  ENV['TELEFONICA_SECURITY_GROUP_REF'] ||
    Fog::Compute[:telefonica].list_security_groups.body['security_groups'].first['name']
end
