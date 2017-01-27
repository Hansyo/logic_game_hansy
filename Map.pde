class Map {
  int data, flag, x, y;
  final int MAP_DROW_STD = 10;

  Map(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  }

  void setdata() {
    this.data = (int)random(0, 3);
    this.flag = 0;
    if (this.data != 0) {
      this.data = 1;
      fill_data++;
    }
  }

  void draw_rect(int split_width_pixel) {
    if (flag  <= 1) {
      if (flag  == 1) {
        fill(120, 80, 200);
      }
      if (flag  == 0) {
        fill(240);
      }
      rect((x +MAP_DROW_STD) * split_width_pixel, (y + MAP_DROW_STD) * split_width_pixel, split_width_pixel, split_width_pixel);
    } else if (flag == 2) {
      fill(150, 200, 150);
      rect((x + MAP_DROW_STD) * split_width_pixel, (y + MAP_DROW_STD) * split_width_pixel, split_width_pixel, split_width_pixel);
      line((x + MAP_DROW_STD) * split_width_pixel, (y + MAP_DROW_STD) * split_width_pixel, (x + MAP_DROW_STD+ 1) * split_width_pixel, (y + MAP_DROW_STD + 1) * split_width_pixel);
    }
  }
}