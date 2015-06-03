include_recipe "nginx"

if node[:active_applications]
  node[:active_applications].each do |app, app_info|
    template "/etc/nginx/sites-available/#{app}.conf" do
      source "app_nginx.conf.erb"
      variables({
        :name              => app,
        :domain_names      => app_info['domain_names'],
        :enable_ssl        => File.exists?("#{node[:rails][:applications_root]}/#{app}/shared/config/certificate.crt"),
        :servers           => app_info['servers']
      })
      notifies :reload, resources(:service => "nginx")
    end

    nginx_site "#{app}.conf" do
      action :enable
    end
  end
end
