{ pkgs, ... }: {

  home.packages = with pkgs; [
    remind
  ];

  home.file.".reminders" = {
    target = ".reminders";
    enable = true;
    text = "INCLUDE ~/Documents/personal/reminders/index.rem";
  };

}
