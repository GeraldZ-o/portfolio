class Spaceship {
  // Member Variables
  int x, y, w, laserCount, turretCount, health;
  //health,speed,ammo,lives
  //boolean shield;
  //color c;
  PImage ship;


  // Constructor
  Spaceship() {
    x= width/2;
    y = height/2;
    w = 100;
    laserCount = 500;
    turretCount = 1;
    health = 100;
    ship = loadImage("ship.png");
  }

  // Member Methods
  void display() {
    imageMode(CENTER);
    image(ship, x, y, w, w);
  }

  void move (int x, int y) {
    this.x = x;
    this.y = y;
  }

  boolean fire () {
    if(laserCount>0) {
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
