# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  fileSystems."/" =
    {
      device = "zroot/root";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    {
      device = "zroot/root/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    {
      device = "zroot/root/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/3593e0a3-3bc7-42a7-b829-685b9e98e6ba";
      fsType = "ext4";
    };

  swapDevices = [];

  nix.maxJobs = lib.mkDefault 16;
}
