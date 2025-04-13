{
  home = rec { # recでAttribute Set内で他の値を参照できるようにする
    username="akazdayo";
    homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
    stateVersion = "22.11";
  };
  programs = {
    home-manager.enable = true;
    mise = {
      enable = true;
    };
  };
}