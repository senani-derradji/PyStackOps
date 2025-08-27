rg_name = "PyStackOps"
location = "West US 2"
vnet_name = "vnet_pystackops"
address_space = ["192.168.0.0/24"]
subnet_name = "subnet_pystackops_test"
subnet_perfix = ["192.168.0.64/26"]

# VM TFVARS
public_ip_name = "publicIP_test"
nic_name = "nic_test"
vm_name = "vm-test"
vm_size = "Standard_B1s"
admin_username = "derradji"

# DB TFVARS
mysql_name = "mysql-pystackops"
mysql_db_name = "pystackopsdb"
mysql_admin = "adminuser"
mysql_password = "Pystackops@123"
mysql_sku_name = "B_Standard_B1ms"