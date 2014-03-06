name "openstack-base"
description "Deploy OpenStack Base role"
run_list(
  "role[os-base]",
  "recipe[openstack-custom]"
)
