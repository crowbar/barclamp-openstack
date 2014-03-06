name "openstack-base"
description "Deploy OpenStack Base role"
run_list(
  "recipe[openstack-custom]",
  "role[os-base]"
)
