class Laser {
  // Member Variables
  int x, y, w, h, speed;
  PImage laser;


  // Constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    w = 5;
    h = 15;
    speed = 10;
    laser = loadImage("laser.png");
  }

  // Member Methods
  void display() {
    imageMode(CENTER);
    image(laser, x, y);
    laser.resize(25, 45);
    image(laser, x, y);
    //tint(128,0,0);
  }

  void move() {
    y = y - speed;
  }

  boolean reachedTop() {
    if (y<-20) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<(r.diam/2)) {
      return true;
    } else {
      return false;
    }
  }
}
