environment = {
  dev = {
    location = "centralus"
    db.edition = "Basic"
    db.sku = "Basic"

    webapp.tier = "Shared"
    webapp.sku = "D1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp.slots = "" 
  }

  prod = {
    location = "centralus"
    db.edition = "Standard"
    db.sku = "S1"

    webapp.tier = "Standard"
    webapp.sku = "S1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp.slots = "blue" 
  }
}

created_by = "colin"
rg_prefix = "cd-pu3"
app = "PartsUnlimited"
