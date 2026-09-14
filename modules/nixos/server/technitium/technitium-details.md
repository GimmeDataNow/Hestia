# Overview
## Compose2Nix

```bash
nix run github:aksiksi/compose2nix -- \
-inputs=docker-compose.yml \
-output=compose.nix \
-include_env_files=false \
-check_bind_mounts=true \
-use_upheld_by=true \
-runtime=docker \
-project=technitium \
-root_path=/home/hallow/containers/technitium
```

## Verify DNS-over-HTTPS

In order to verify DNS-over-HTTPS when docker is running you have to run:
```bash
sudo tcpdump -ni any port 443 and host 194.242.2.4
```
If logs are flowing in that mean that traffic is flowing.

If you want to verify that no unencrypted traffic is running then you have to run:
```bash
sudo tcpdump -ni any port 53 and host 194.242.2.4 
```
If no logs are showing then that means no traffic is flowing there
