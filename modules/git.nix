{pkgs, ...}: {
  programs.git = {
    enable = true;
    userEmail = "anlarionov@gmail.com";
    userName = "Andrey \"MOU\" Larionov";
    signing = {
      key = "5FF293FC94C01D6A";
      signByDefault = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      rerere = {
        enabled = true;
      };
    };
    includes = [];
  };
}
