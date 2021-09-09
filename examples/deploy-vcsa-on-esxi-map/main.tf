locals {
  # Deployment Details
  infra_deploy   = yamldecode(file("${path.module}/deploy_vcsa_on_esxi.yaml"))
  deploy_vcenter = local.infra_deploy.deploy_vcenter
}

module "deploy_vcenter" {
  source                = "infada/vcsa-deploy/vsphere"
  version		= "1.1.0"
  for_each              = local.deploy_vcenter
  deploy_type           = each.value.deploy_type
  esxi_hostname         = each.value.esxi_hostname
  esxi_username         = each.value.esxi_username
  esxi_password         = each.value.esxi_password
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
  windows		= each.value.windows
  binaries_path         = each.value.binaries_path
}
