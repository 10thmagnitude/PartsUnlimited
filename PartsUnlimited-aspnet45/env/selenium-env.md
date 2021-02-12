# Selenium Tests via ACI

To run Selenium tests effectively, you can use a Grid to farm tests out to headless Selenium agents. The steps below create an ACI group with an AzDO agent and Selenium agents.

Edit the `selenium-aci.release.yaml` file and replace the tokens accordingly.

Then run the following command:

```sh
az group create -g cd-pu3-aci -l centralus
az container create -g cd-pu3-aci -n cd-aci -f selenium-aci.release.yaml
```