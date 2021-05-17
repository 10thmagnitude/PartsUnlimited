environment = {
  dev = {
    location = "centralus"
    db_edition = "Basic"
    db_sku = "Basic"

    webapp_tier = "Shared"
    webapp_sku = "D1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp_slots = "" 
  }

  prod = {
    location = "centralus"
    db_edition = "Standard"
    db_sku = "S1"

    webapp_tier = "Standard"
    webapp_sku = "S1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp_slots = "blue" 
  }
}

created_by = "colin"
rg_prefix = "cd-pu3"
app = "PartsUnlimited"
