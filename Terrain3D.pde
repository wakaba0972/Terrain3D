int w, h;
int scl = 50;
int cols, rows;
float yoff, xoff;
float flying = 0;
float terrain[][];

void setup() {
  size(displayWidth, displayHeight, P3D);
  surface.setTitle("Terrain3D");
  //surface.setLocation(0, 0);
  w = width + 500;
  h = height + 400;
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw() {
  background(0);
  stroke(255);
  noFill();

  yoff = flying;
  for (int y = 0; y < rows; y++) {
    xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -200, 200);
      xoff += 0.15;
    }
    yoff += 0.15;
  }
  flying -= 0.01;

  translate(width / 2, height / 2);
  rotateX(PI/3);
  translate(-w / 2, -h / 2);

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}
