Rails.application.routes.draw do

  mount BarclampOpenstack::Engine => "/barclamp_openstack"
end
