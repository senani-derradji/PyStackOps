provider "azuread" {
  tenant_id = "76674a26-d9d7-4039-9b86-60f9555e35eb"
}

locals {
  users = csvdecode(file("${path.module}/data.csv"))
}

resource "azuread_user" "users" {
  for_each = { for u in local.users : u.user_principal_name => u }

  user_principal_name   = each.value.user_principal_name
  display_name          = each.value.display_name
  password              = each.value.password
  force_password_change = true
}

resource "azuread_group" "groups" {
  for_each         = { for u in local.users : u.group => u... }
  display_name     = each.key
  security_enabled = true
}

resource "azuread_group_member" "members" {
  for_each = { for u in local.users : u.user_principal_name => u }

  group_object_id  = azuread_group.groups[each.value.group].object_id
  member_object_id = azuread_user.users[each.key].object_id
}
