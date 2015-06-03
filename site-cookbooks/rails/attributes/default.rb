default["rails"]["applications_root"] = "/u/apps"
default["rbenv"]["binaries_url"] = "https://intercityup.com/binaries/ruby/ubuntu"
default["rbenv"]["available_binaries"] = %w(2.2.0 2.1.1)

case node["platform_family"]
when "debian"
  if node["platform"] == "ubuntu" && node["platform_version"] == "14.04"
    default["nginx"]["pid"] = "/run/nginx.pid"
  end
end
