{ config, inputs, ... }:

{
  imports = [
    inputs.srvos.nixosModules.mixins-nginx
    inputs.srvos.nixosModules.hardware-hetzner-online-amd
    ./nixpkgs-update.nix
    ./nixpkgs-update-backup.nix
    inputs.self.nixosModules.common
    inputs.self.nixosModules.builder
    inputs.self.nixosModules.disko-zfs
    inputs.self.nixosModules.emergency-access
  ];

  # set in srvos, remove when reinstalling
  networking.hostId = "deadbeef";

  # the default zpool import services somehow times out while this import works fine?
  boot.initrd.systemd.services.zfs-import-zroot.serviceConfig.ExecStartPre = "${config.boot.zfs.package}/bin/zpool import -N -f zroot";

  nixCommunity.gc.gbFree = 500;

  boot.kernelParams = [ "zfs.zfs_arc_max=${toString (24 * 1024 * 1024 * 1024)}" ]; # 24GB, try to limit OOM kills / reboots

  networking.hostName = "build02";
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  systemd.network.networks."10-uplink".networkConfig.Address = "2a01:4f9:3b:41d9::1";

  system.stateVersion = "23.11";
}
