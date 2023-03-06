provider "bigip" {
  address = ""
}

resource "bigip_ltm_monitor" "monitor" {
  name     = "/Common/"
  parent   = "/Common/http"
  send     = "GET /some/path\r\n"
  timeout  = "46"
  interval = "15"
}

resource "bigip_ltm_pool" "pool" {
  name                = "/Common/"
  load_balancing_mode = "least-connections-node"
  monitors            = ["/Common/"]
  allow_snat          = "yes"
  allow_nat           = "yes"
  depends_on = [bigip_ltm_monitor.monitor]
}


resource "bigip_ltm_node" "node1" {
  name             = "/Common/"
  address          = ""
    }
  resource "bigip_ltm_node" "node2" {
  name             = "/Common/"
  address          = ""
    }
resource "bigip_ltm_node" "node3" {
  name             = "/Common/"
  address          = ""
    }
  resource "bigip_ltm_node" "node4" {
  name             = "/Common/"
  address          = ""
    }
                                         

resource "bigip_ltm_pool_attachment" "cgr-prd_poolterraform" {
  for_each = toset([bigip_ltm_node.node1.name, bigip_ltm_node.node2.name, bigip_ltm_node.node3.name, bigip_ltm_node.node4.name])
  pool     = bigip_ltm_pool.pool.name
  node     = "${each.key}:8081"
} 

