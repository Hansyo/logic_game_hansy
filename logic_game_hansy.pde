final int NUM = 400;
final int MATRIX = 20;
final int split_rate = 30;
int[][] index_all_data=new int[40][10];
int fill_data;
Map[][] map = new Map[MATRIX][MATRIX];

void setup() {
  size(600, 600);
  smooth();
  for (int i = 0; i < MATRIX; i++) {
    for (int j = 0; j < MATRIX; j++) {
      map[i][j] = new Map(i, j);
    }
  }
  setup_game();
}

void draw() {
  background(240);
  int split_width_pixel = (int)(width / split_rate); 
  draw_rect(split_width_pixel);
  draw_split_line(split_width_pixel); 
  draw_hint();
  draw_mouse_rect();
  //win_game();
}

void draw_split_line(int split_width_pixel) {
  for (int i = 0; i < split_rate; i++) {
    if (i % 10 == 0) {
      stroke(200, 15, 15);
      strokeWeight(5);
    } else {
      stroke(0);
      strokeWeight(2);
    }
    line(i * split_width_pixel, 0, i * split_width_pixel, height);
    line(0, i * split_width_pixel, width, i * split_width_pixel);
  }
  stroke(0);
  fill(240);
  noStroke();
  rect(0, 0, 10 * split_width_pixel, 10 * split_width_pixel);
  stroke(0);
}


void count_data() {
  int count;
  for (int i = 0; i < MATRIX; i++) {
    count = 0;
    for (int j = 0; j < MATRIX; j++) {
      while (map[i][j].data == 1) {
        index_all_data[i][count]++;
        j++;
        if (j >= MATRIX) break;
      }
      if (index_all_data[i][count] != 0) {
        count++;
      }
    }
  }

  for (int i = 0; i < MATRIX; i++) {
    count = 0;
    for (int j = 0; j < MATRIX; j++) {
      while (map[j][i].data == 1) {
        index_all_data[i + MATRIX][count]++;
        j++;
        if (j >= MATRIX) break;
      }
      if (index_all_data[i + MATRIX][count] != 0) {
        count++;
      }
    }
  }
}


void setup_game() {
  fill_data = 0;
  for (int i = 0; i < MATRIX + MATRIX; i++) {
    for (int j = 0; j < 10; j++) {
      index_all_data[i][j] = 0;
    }
  }
  for (int i = 0; i < MATRIX; i++) {
    for (int j = 0; j < MATRIX; j++) {
      map[i][j].setdata();
    }
  }
  count_data();
}

void draw_hint() {
  fill(0);
  int d_count, x_count, y_count;
  int split_width_pixel = (int)(width / split_rate);
  for (int i = 0; i < MATRIX; i++) {
    d_count = 9;
    x_count = 9;
    for (int j = 9; j >= 0; j--) {
      if (index_all_data[i][j] != 0) {
        text(index_all_data[i][d_count], x_count * split_width_pixel + 3, (i + 1)* split_width_pixel + 10 * split_width_pixel - 4);
        x_count--;
      }
      d_count--;
    }
  }
  for (int i = 0; i < MATRIX; i++) {
    d_count = 9;
    y_count = 10;
    for (int j = 9; j >= 0; j--) {
      if (index_all_data[i + MATRIX][j] != 0) {
        text(index_all_data[i + MATRIX][d_count], (i + 10) * split_width_pixel + 5, y_count * split_width_pixel - 4);
        y_count--;
      }
      d_count--;
    }
  }
}


void draw_mouse_rect() {
  int split_width_pixel = (int)(width / split_rate);
  int rectX = (int)(mouseX / split_width_pixel);
  int rectY = (int)(mouseY / split_width_pixel);
  fill(255, 0, 0, 100);
  rect(rectX * split_width_pixel, rectY * split_width_pixel, split_width_pixel, split_width_pixel);
}

void mousePressed() {
  int split_width_pixel = (int)(width / split_rate);
  int rectX = (int)(mouseX / split_width_pixel);
  int rectY = (int)(mouseY / split_width_pixel);
  switch(mouseButton) {
  case LEFT:
    if (rectX - 10 >= 0 && rectY - 10 >= 0) {
      if (map[rectX - 10][rectY - 10].flag != 2) {
        if (map[rectX - 10][rectY - 10].flag == 1) {
          map[rectX - 10][rectY - 10].flag = 0;
        } else if (map[rectX - 10][rectY - 10].flag == 0) {
          map[rectX - 10][rectY - 10].flag = 1;
        }
      }
    }
    break;
  case RIGHT:
    if ((rectX - 10) >= 0 && (rectY - 10) >= 0) {
      if (map[rectX - 10][rectY - 10].flag == 2) {
        map[rectX - 10][rectY - 10].flag = 0;
      } else if (map[rectX - 10][rectY - 10].flag == 0) {
        map[rectX - 10][rectY - 10].flag = 2;
      }
    }
    break;
  }
}

void win_game() {
  int count = 0;
  for (int i = 0; i < MATRIX; i++) {
    for (int j = 0; j < MATRIX; j++) {
      if (map[i][j].flag == 1) {
        if (map[i][j].flag == map[i][j].data) {
          count++;
        }
      }
    }
  }

  if (fill_data == count) {
    fill(240);
    rect(0, 0, width, height);
    fill(0);
    text("You win the Game!!", width / 2, height /3);
  }
}


void draw_rect(int split_width_pixel) {
  for (int i = 0; i < MATRIX; i++) {
    for (int j = 0; j < MATRIX; j++) {
      map[i][j].draw_rect(split_width_pixel);
    }
  }
}

void keyPressed() {
  if (key == 'R') {
    setup_game();
  }
}