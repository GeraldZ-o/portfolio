// Aidan Stephen | September 23, 2025 | SpaceGame
Spaceship gerald;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
Timer rockTimer, puTimer;
int score, rocksPassed, diam;
boolean play;
PImage space;
PFont font;
import processing.sound.*;
SoundFile blast;
import processing.sound.*;
SoundFile explode;
import processing.sound.*;
SoundFile itemGet;
import gifAnimation.*;
Gif emoji;

void setup() {
  size(750, 750);
  gerald = new Spaceship();
  puTimer = new Timer(5000);
  puTimer.start();
  rockTimer = new Timer(2000);
  rockTimer.start();
  score = 0;
  rocksPassed = 0;
  space = loadImage("space.png");
  blast = new SoundFile(this, "fire.wav");
  explode = new SoundFile(this, "explosion.wav");
  itemGet = new SoundFile(this, "item.wav");
  emoji = new Gif(this, "emoji.gif");
}

void draw() {
  if (!play) {
    startScreen ();
  } else {
    background(0);

    // Adding Stars
    stars.add(new Star());

    // Distributing Rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
    }

    // Distributing PowerUps
    if (puTimer.isFinished()) {
      powerups.add(new PowerUp());
      puTimer.start();
    }

    //Display of Stars
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }

    //Display of PowerUp
    //if (score == 10 || score == 20 || score == 30 || score == 50) {
    for (int i = 0; i < powerups.size(); i++) {
      PowerUp powerup = powerups.get(i);
      // collision detection between powerup and ship
      if (powerup.intersect(gerald)) {
        if (itemGet.isPlaying()) {
          itemGet.stop();
          itemGet.play();
        } else
          itemGet.play();
        powerups.remove(powerup);
        //What type of powerup benefit player
        if (powerup.type == 'H') {
          gerald.health += 20;
        } else if (powerup.type == 'T') {
          gerald.turretCount += 1;
        } else if (powerup.type == 'A') {
          gerald.laserCount += 100;
        }
      }
      powerup.display();
      powerup.move();
      if (powerup.reachedBottom()) {
        powerups.remove(powerup);
        i--;
      }
    }
    //}

    //Display of Rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      // collision detection between rock and ship
      if (gerald.intersect(rock)) {
        rocks.remove(rock);
        score = score + 1;
        gerald.health -= rock.diam/10;
        if (explode.isPlaying()) {
          explode.stop();
          explode.play();
        } else
          explode.play();
        if (gerald.health < 0) {
          gerald.health = 0;
        }
      }
      rock.display();
      rock.move();
      if (rock.reachedBottom()) {
        rocks.remove(rock);
        i--;
        rocksPassed++;
      }
      //if (score == 50) {
      //rocks.remove(rock);
      //i--;
    }

    //Display of Lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j<rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (laser.intersect(r)) {
          r.diam = r.diam - 50;
          lasers.remove(laser);
          if (r.diam < 50) {
            rocks.remove(r);
            score = score + 1;
            if (explode.isPlaying()) {
              explode.stop();
              explode.play();
            } else
              explode.play();
          }
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()==true) {
        lasers.remove(laser);
      }
      //println(lasers.size());
    }
   

    gerald.display();
    gerald.move(mouseX, mouseY);

    infoPanel();
    if (rocksPassed>3 || gerald.health<1) {
      gameOver();
      noLoop();
    }
  }
}

//Firing and Number of Turrets
void mousePressed() {
  if (gerald.turretCount == 1) {
    lasers.add(new Laser(gerald.x, gerald.y));
  } else  if (gerald.turretCount == 2) {
    lasers.add(new Laser(gerald.x-10, gerald.y));
    lasers.add(new Laser(gerald.x+10, gerald.y));
  } else  if (gerald.turretCount == 3) {
    lasers.add(new Laser(gerald.x, gerald.y));
    lasers.add(new Laser(gerald.x-10, gerald.y));
    lasers.add(new Laser(gerald.x+10, gerald.y));
  } else  if (gerald.turretCount == 4) {
    lasers.add(new Laser(gerald.x+20, gerald.y));
    lasers.add(new Laser(gerald.x-10, gerald.y));
    lasers.add(new Laser(gerald.x+10, gerald.y));
    lasers.add(new Laser(gerald.x-20, gerald.y));
  } else  if (gerald.turretCount == 5) {
    lasers.add(new Laser(gerald.x+20, gerald.y));
    lasers.add(new Laser(gerald.x-10, gerald.y));
    lasers.add(new Laser(gerald.x+10, gerald.y));
    lasers.add(new Laser(gerald.x-20, gerald.y));
    lasers.add(new Laser(gerald.x, gerald.y));
  }
  if (gerald.turretCount > 5) {
    gerald.turretCount = 5;
    gerald.health += 20;
    gerald.laserCount += 100;
  }
  if (blast.isPlaying()) {
    blast.stop();
    blast.play();
  } else
    blast.play();
  gerald.laserCount -= gerald.turretCount;
}
void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, 25, width, 50);
  fill(220);
  textAlign(CORNER);
  textSize(25);
  text("Score: " + score, 320, 40);
  text("Passed Rocks: " + rocksPassed + "/3", 560, 40);
  text("Health: " + gerald.health, 430, 40);
  text("Ammo: " + gerald.laserCount, 15, 40);
  text("Turrets: " + gerald.turretCount, 175, 40);
  fill(255);
  if (gerald.health < 100) {
    rect(this.gerald.x, this.gerald.y + 75, 105, 15);
  } else {
    rect(this.gerald.x, this.gerald.y + 75, gerald.health + 5, 15);
  }
  fill(52, 21, 57);
  rect(this.gerald.x, this.gerald.y + 75, gerald.health, 10);
}
void gameOver() {
  background (0);
  image(emoji, 375, 375);
  emoji.loop();
  emoji.play();
  //rectMode(CENTER);
  //fill (255);
  //rect(width/2, height/2, 300, 100);
  fill (0);
  textSize(50);
  textAlign(CENTER);
  text("YOU LOSE!", width/2, height/2);
  fill(255);
  textAlign(CENTER);
  textSize(25);
  text("Score: " + score, width/2, height/2 + 40);
  text("Ammo: " + gerald.laserCount, width/2, height/2 + 80);
  text("Rocks Passed: " + rocksPassed, width/2, height/2 + 120);
}
void startScreen () {
  background (0);
  stars.add(new Star());
  for (int i = 0; i < stars.size(); i++) {
    Star star = stars.get(i);
    star.display();
    star.move();
    if (star.reachedBottom()) {
      stars.remove(star);
    }
  }
  imageMode(CENTER);
  image(space, 375, 375);
  textAlign(CENTER);
  textSize(100);
  //font = createFont("spel.ttf", 100);
  //textFont(font);
  text("SPACE GAME", width/2, height/2);
  textAlign(CENTER);
  textSize(50);
  text("Press Enter to STart!", width/2, height/2 + 100);
  textAlign(CENTER);
  textSize(30);
  text("Aidan Stephen 10/7/2025", width/2, height/2 + 200);
  if (keyPressed) {
    if (key == ENTER) {
      play = true;
    }
  }
}
