environment = {
  dev = {
    location = "eastus"
    db.edition = "Basic"
    db.sku = "Basic"

    webapp.tier = "Free"
    webapp.sku = "F1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp.slots = "" 
  }

  prod = {
    location = "eastus"
    db.edition = "Basic"
    db.sku = "Basic"

    webapp.tier = "Standard"
    webapp.sku = "S1"
    # this has to be a comma-separated list since an array causes a "not homogeneous types" error
    # for no slots, leave as an empty string
    webapp.slots = "blue" 
  }
}

created_by = "colin"