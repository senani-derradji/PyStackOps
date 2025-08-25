location="WestUS2"
account_name="sttfstate12123"

az group create --name rg-tfstate --location $location

az storage account create \
  --name $account_name \
  --resource-group rg-tfstate \
  --location $location \
  --sku Standard_LRS

az storage container create \
  --name tfstate \
  --account-name $account_name
