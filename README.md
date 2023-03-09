# fly-hole

A publicly available [Pi-Hole](https://pi-hole.net) on [Fly.io](https://fly.io).

The resolver supports just DNS-over-TLS.
UDP (or TCP) port 53 are blocked to [prevent abuse](https://discourse.pi-hole.net/t/specifying-udp-bind-address/61698).

Statistics and settings remain persistent with Fly Volumes.

Not yet implemented:

* Cross instance sync
* DNS-over-HTTPS
* Custom Pi Hole configs - the default setup is good enough for me at the moment.

## Deploying

0. [Get started with Fly.io](https://fly.io/docs/hands-on/install-flyctl/).

1. Create the app with (it'll let you pick a unique name and region):
    ```
    $ flyctl launch --no-deploy --copy-config
    ```
    Note that this command modifies `fly.toml` - it adds `app` and `primary_region` to it; but it also removes comments and changes the actual service setup. Undo these latter changes.

2. You'll have to create volume(s) named `ph_data` on every region you'd wish to deploy to:
    ```
    $ flyctl vol create ph_data --region REGION --size 1
    ```

3. Finally,
    ```
    $ flyctl deploy
    ```

4. DNS shall be served from `APP-NAME.fly.dev` over DoT, TCP port 853.

