class Player {
  int x, y;
  int px;
  PImage standRight, standLeft;
  PImage[] walkRight;
  PImage[] walkLeft;
  int currentImage;
  int time;
  boolean goingRight;
  int w = 100;
  int h = 150;

  Player(int x, int y, PImage walking1Right, PImage standRight, PImage walking2Right, 
    PImage walking1Left, PImage standLeft, PImage walking2Left) {
    this.standRight = standRight;
    this.standLeft = standLeft;
    this.walkRight = new PImage[]{walking1Right, standRight, walking2Right, standRight};
    this.walkLeft = new PImage[]{walking1Left, standLeft, walking2Left, standLeft};
    this.x = x;
    this.y = y - h / 2;
    this.px = x;
    time = frameCount;
    goingRight =true;
    currentImage = 1;
  }

  void render() {
    pushStyle();
    imageMode(CENTER);
    //facing right direction
    if (goingRight) {
      //standing still
      if (!(keyPressed && (keyCode == LEFT || keyCode == RIGHT))) {
        image(walkRight[1], x, y, w, h); //standing facing right
      } else {
        //walking right 
        getImage();
        image(walkRight[currentImage], x, y, w, h);
      }
    } 
    //facing left direction
    else {
      if (!(keyPressed && (keyCode == LEFT || keyCode == RIGHT))) {
        image(walkLeft[1], x, y, w, h); //standing facing left
      } else {
        //walking left
        getImage();
        image(walkLeft[currentImage], x, y, w, h);
      }
    }
    popStyle();
  }

  void getImage() {
    //getting direction
    if (px < x) {
      goingRight = true;
    }
    if (px > x) {
      goingRight = false;
    }
    // time to change image
    if (frameCount > time + 10) {
      //if end of array, 
      if (currentImage == walkRight.length - 1) {
        currentImage = 0;
      } else {
        currentImage ++;
      }
      time = frameCount;
    }
  }

  void onKey() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        if (x < 4000) {
          this.px = this.x;
          this.x += 15;
        }
      }
      if (keyCode == LEFT && this.y > 0) {
        if (x > 0) {
          this.px = this.x;
          this.x -= 15;
        }
      }
    }
  }
}