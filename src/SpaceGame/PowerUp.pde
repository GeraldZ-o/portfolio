class PowerUp {
  // Member Variables
  int x, y, diam, speed;
  char type;
  color c1;
  PImage powerup1;


  // Constructor
  PowerUp() {
    x = int(random(width));
    y = -100;
    diam = 75;
    speed = 5;
    if (random(10)>7) {
      powerup1 = loadImage("health.png");
      type = 'H';
    } else if (random(10)>6) {
      powerup1 = loadImage("turret.png");
      type = 'T';
    } else {
      powerup1 = loadImage("ammo.png");
      type = 'A';
      c1 = color(55, 0, 0);
    }
  }

  // Member Methods
  void display() {
    imageMode(CENTER);
    if (diam<1) {
      diam = 10;
    }
    image(powerup1, x, y, diam, diam);
  }

  void move() {
    y = y + speed;
  }

  boolean reachedBottom() {
    if (y>height+diam) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Spaceship gerald) {
    float d = dist(x, y, gerald.x, gerald.y);
    if (d<(gerald.w/2)) {
      return true;
    } else {
      return false;
    }
  }
}
