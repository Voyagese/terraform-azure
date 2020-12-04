provider 

```
provider "azurerm" {
  version = "1.27"
}

resource "azurerm_resource_group" "dev" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}
```

Subnet 
```
resource "azurerm_subnet" "private1" {
  name                 = "private1"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  address_prefix       = "${var.private_subnet1_range}"
}

resource "azurerm_subnet" "private2" {
  name                 = "private2"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  address_prefix       = "${var.private_subnet2_range}"
}

resource "azurerm_subnet" "private3" {
  name                 = "private3"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet1.name}"
  address_prefix       = "${var.private_subnet3_range}"
}
```
Sec-gr

```
resource "azurerm_network_security_group" "sec_group1" {
  name                = "${var.environment}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = "${var.tags}"
}
```

NIC

```
resource "azurerm_network_interface" "nic1" {
  name                = "nic1"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.private1.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.IP.id}"
  }

  tags = "${var.tags}"
}

resource "azurerm_network_interface" "nic2" {
  name                = "nic2"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = "${azurerm_subnet.private2.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.IP2.id}"
  }

  tags = "${var.tags}"
}

resource "azurerm_network_interface" "nic3" {
  name                = "nic3"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "testconfiguration3"
    subnet_id                     = "${azurerm_subnet.private3.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.IP3.id}"
  }

  tags = "${var.tags}"
}
```
aztfvars
```
private_subnet1_range = "10.0.1.0/24"
private_subnet2_range = "10.0.2.0/24"
private_subnet3_range = "10.0.3.0/24"
resource_group_name = "dev"            #Precreate this while creating Backend Container
security_group_name = "sec_group1"
vm1_computername = "vm1"
vm2_computername = "vm2"
vm3_computername = "vm3"
address_space = "10.0.0.0/16"
vnet_name = "vnet1"
location = "westus2"
environment = "dev"

#OS Information
publisher = "OpenLogic"
offer = "CentOS"
sku = "7.5"
version = "latest"
admin_username = "centos"
vm_size = "Standard_DS1_v2"

tags = {
	Name = "VPC_Project"
	Environment = "Dev"
	Team = "DevOps"
	Department = "IT"
	Bill = "CFO"
	Quarter = "3"
}

```



