class Rock {
  // Member Variables
  int x, y, diam, speed;
  PImage rock1, rock2, rock3;


  // Constructor
  Rock() {
    x = int(random(width));
    y = -100+diam;
    diam = int(random(50, 300) + score*5);
    speed = int(random(2, 8) + score/5);
    if (random(1000)<20) {
      rock1 = loadImage("smile.png");
    } else if (random(10)>8) {
      rock1 = loadImage("rock02.png");
    } else if (random(10)>5) {
      rock1 = loadImage("rock03.png");
    } else if (random(10)>0.01) {
      rock1 = loadImage("rock01.png");
    //} else if (score == 50) {
    //  rock1 = loadImage("smile.png");
    //  diam = 500 + (gerald.turretCount * 50) + score;
    //  speed = 1;
    //}
  }
}
  // Member Methods
  void display() {
    imageMode(CENTER);
    if (diam<1) {
      diam = 10;
    }
    image(rock1, x, y, diam, diam);
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
}
