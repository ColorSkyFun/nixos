{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # 安装 LookGlass 和其他必要的工具
  environment.systemPackages = with pkgs; [
    libvirt
    virt-manager
  ];
}
