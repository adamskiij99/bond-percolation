float gridSize = 30;
int rows;
int cols;
color bg = #5050DD;

float[][] percVert;
float[][] percHorz;
float percThreshold = 0.5;

void setup() {
  fullScreen();
  background(bg);
  fill(0);
  noStroke();

  rows = 1 + (int)(height / gridSize);
  cols = 1 + (int)(width / gridSize);

  percVert = new float[rows][cols];
  percHorz = new float[rows][cols];
  
  // initialise percolation
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      percVert[i][j] = random(1);
      percHorz[i][j] = random(1);
    }
  }
}

void draw() {
  // threshold: probability of "edge deletion" based on how far right the mouse is on the screen. (so middle = 50%)
  percThreshold = (float)mouseX / width;
  background(bg);
  
  // draw instance based on threshold
  for (int j = 0; j < cols; j++) {
    for (int i = 0; i < rows; i++) {
      vtx(i * gridSize, j * gridSize);
      if (percVert[i][j] < percThreshold) {
        edgeVert(i * gridSize, j * gridSize);
      }
      if (percHorz[i][j] < percThreshold) {
        edgeHorz(i * gridSize, j * gridSize);
      }
    }
    vtx(width, j * gridSize);
    if (percVert[rows - 1][j] < percThreshold) {
      edgeVert(width, j * gridSize);
    }
  }
}

// vertex function
void vtx(float y, float x) {
  ellipse(x, y, gridSize / 1.5, gridSize / 1.5);
}

// horizontal edge function
void edgeHorz(float y, float x) {
  stroke(0);
  strokeWeight(gridSize / 5);
  line(x, y, x + gridSize, y);
  strokeWeight(0.5 + gridSize / 10);
  // I've found through experimentation that this setup looks quite nice
  line(x, y - gridSize / 4, x + gridSize, y + gridSize / 4);
  line(x, y + gridSize / 4, x + gridSize, y - gridSize / 4);
  noStroke();
}

// vertical edge function
void edgeVert(float y, float x) {
  stroke(0);
  strokeWeight(gridSize / 5);
  line(x, y, x, y + gridSize);
  strokeWeight(0.5 + gridSize / 10);
  line(x - gridSize / 4, y, x + gridSize / 4, y + gridSize);
  line(x + gridSize / 4, y, x - gridSize / 4, y + gridSize);
  noStroke();
}

// regenerate percolation instance
void mouseClicked() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      percVert[i][j] = random(1);
      percHorz[i][j] = random(1);
    }
  }
}
