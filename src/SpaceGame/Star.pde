class Star {
  // Member Variables
  int x, y, w, speed;
  PImage star;


  // Constructor
  Star() {
    x = int(random(width));
    y = -10;
    w = int(random(1, 4));
    speed = int(random(2, 8));
  }

  // Member Methods
  void display() {
    fill(random(200, 255), random(200, 255), random(200, 255));
    ellipse(x, y, w, w);
  }

  void move () {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y>height+w) {
      return true;
    } else {
      return false;
    }
  }
}
