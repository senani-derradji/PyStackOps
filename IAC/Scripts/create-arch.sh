# ./create-resource-storage-az.sh
cd ..
mkdir modules && cd modules
mkdir network compute database redis
touch network/main.tf network/variables.tf network/output.tf
touch database/main.tf database/variables.tf database/output.tf
touch compute/main.tf compute/variables.tf compute/output.tf
touch redis/main.tf redis/variables.tf redis/output.tf
echo "modules_done ....."
cd ..
mkdir envs && cd envs
mkdir dev test prod
touch dev/main.tf test/main.tf prod/main.tf
touch dev/terraform.tfvars test/terraform.tfvars prod/terraform.tfvars

