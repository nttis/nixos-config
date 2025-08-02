{...}: {
  programs.feh = {
    enable = true;

    keybindings = {
      next_img = "S-Right";
      prev_img = "S-Left";

      zoom_in = "equal";
      zoom_out = "minus";

      scroll_left = ["Left" "h"];
      scroll_right = ["Right" "l"];
      scroll_up = ["Up" "j"];
      scroll_down = ["Down" "k"];
    };
  };
}
