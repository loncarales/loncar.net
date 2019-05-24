provider "scaleway" {}

resource "scaleway_ip" "ip" {
  server = "${scaleway_server.loncar-net.id}"
}

data "scaleway_image" "debian-base" {
  architecture = "arm"
  name         = "debian-base"
}

resource "scaleway_server" "loncar-net" {
  name           = "loncar-net"
  image          = "${data.scaleway_image.debian-base.id}"
  type           = "C1"
  security_group = "${scaleway_security_group.loncar-net.id}"
}

resource "scaleway_security_group" "loncar-net" {
  name                    = "loncar-net"
  description             = "allow ssh and mosh traffic"
  enable_default_security = true
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"
}

resource "scaleway_security_group_rule" "ssh_accept" {
  security_group = "${scaleway_security_group.loncar-net.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 22
}

variable "mosh_ports" {
  default = [60000, 60001, 60002, 60003, 60004, 60005, 60006, 60007, 60008, 60009, 60010]
}

resource "scaleway_security_group_rule" "mosh_accept" {
  security_group = "${scaleway_security_group.loncar-net.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = "${element(var.mosh_ports, count.index)}"
  count     = "${length(var.mosh_ports)}"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.loncar-net.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.loncar-net.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}
