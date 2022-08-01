## Init scripts

Create a `.sh` file for example to download/update your mods when the server starts.

Example `download_mods.sh`:

```shell
# Using helper methods
DlGithubFile CalamityMod        v1.5.1.6    MountainDrew8   CalamityMod
DlModBrowser CalamityModMusic
DlModBrowser ClamExtraMusic
```
