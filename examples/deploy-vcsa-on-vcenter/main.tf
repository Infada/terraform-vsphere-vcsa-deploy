locals {
  # Deployment Details
  infra_deploy   = yamldecode(file("${path.module}/deploy_vcsa_on_vcenter.yaml"))
  deploy_vcenter = local.infra_deploy.deploy_vcenter
}

module "deploy_vcenter" {
  source                = "github.com/kalenarndt/terraform-vsphere-vcsa"
  for_each              = local.deploy_vcenter
  type                  = "vc"
  vc_datacenter         = each.value.vc_datacenter
  vc_username           = each.value.vc_username
  vc_hostname           = each.value.vc_hostname
  vc_password           = each.value.vc_password
  vc_cluster            = each.value.vc_cluster
  vcsa_network          = each.value.vcsa_network
  vcsa_datastore        = each.value.vcsa_datastore
  disk_mode             = each.value.disk_mode
  deployment_size       = each.value.deployment_size
  vcenter_hostname      = each.value.vcenter_hostname
  ip_family             = each.value.ip_family
  network_mode          = each.value.network_mode
  vcenter_fqdn          = each.value.system_name
  vcenter_ip            = each.value.vcenter_ip
  vcenter_prefix        = each.value.vcenter_prefix
  vcenter_gateway       = each.value.vcenter_gateway
  vcenter_dns           = each.value.vcenter_dns
  vcenter_root_password = each.value.vcenter_root_password
  vcenter_ntp_server    = each.value.vcenter_ntp_server
  vcenter_ssh_enabled   = each.value.vcenter_ssh_enabled
  vcenter_sso_password  = each.value.vcenter_sso_password
  vcenter_sso_domain    = each.value.vcenter_sso_domain
  vcenter_ceip_status   = each.value.vcenter_ceip_status
  binaries_path         = each.value.binaries_path
}
