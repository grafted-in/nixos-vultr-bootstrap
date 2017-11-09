{ config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gzip
    nix-repl
    vim
    wget
    zip
  ];

  environment.variables.EDITOR = "vim";

  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos";

  nixpkgs.config.allowUnfree = true;

  programs.bash.enableCompletion = true;
  programs.ssh.startAgent = true;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "prohibit-password";

  time.timeZone = "America/New_York";

  users.users.root.openssh.authorizedKeys.keys = with import ./ssh-keys.nix; [ bootstrap ];

  system.stateVersion = "17.09";
}
