locals {
  binaries_path = var.binaries_path
  vcsa_template = templatefile("${path.module}/Template/vcsa-${var.deploy_type}.json.tmpl", {
    esxi_hostname         = var.esxi_hostname
    vc_hostname           = var.vc_hostname
    esxi_username         = var.esxi_username
    vc_username           = var.vc_username
    esxi_password         = var.esxi_password
    vc_password           = var.vc_password
    vcsa_network          = var.vcsa_network
    vc_datacenter         = var.vc_datacenter
    vc_cluster            = var.vc_cluster
    vcsa_datastore        = var.vcsa_datastore
    disk_mode             = var.disk_mode
    deployment_size       = var.deployment_size
    vcenter_hostname      = var.vcenter_hostname
    ip_family             = var.ip_family
    network_mode          = var.network_mode
    vcenter_fqdn          = var.vcenter_fqdn
    vcenter_ip            = var.vcenter_ip
    vcenter_prefix        = var.vcenter_prefix
    vcenter_gateway       = var.vcenter_gateway
    vcenter_dns           = var.vcenter_dns
    vcenter_root_password = var.vcenter_root_password
    vcenter_ntp_server    = var.vcenter_ntp_server
    vcenter_ssh_enabled   = var.vcenter_ssh_enabled
    vcenter_sso_password  = var.vcenter_sso_password
    vcenter_sso_domain    = var.vcenter_sso_domain
    vcenter_ceip_status   = var.vcenter_ceip_status
  })
}

resource "local_file" "vcsa_template_to_json" {
  filename = "${local.binaries_path}/vcsa-${var.deploy_type}.json"
  content  = local.vcsa_template
}

resource "null_resource" "vcsa_windows_deploy" {
  provisioner "local-exec" {
    command = "${local.binaries_path}/vcsa-cli-installer/win32/vcsa-deploy.exe install --accept-eula --acknowledge-ceip --no-ssl-certificate-verification ${local.binaries_path}/vcsa-${var.deploy_type}.json"
  }
}

provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "${var.vcenter_sso_password}"
  vsphere_server = "${var.vcenter_fqdn}"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
