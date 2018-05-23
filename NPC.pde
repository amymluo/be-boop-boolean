// represents an NPC robot dude
class NPC {
  boolean complete, displayCircuit, walkedPast;
  Circuit circuit;
  PImage img;
  PImage dead;
  boolean click;
  int x, y, w, h;
  Button button;

  NPC(PImage img, PImage dead, Circuit circuit, int x, int y) {
    this.img = img;
    this.dead = dead;
    this.circuit = circuit;
    this.complete = false;
    this.displayCircuit = false;
    this.walkedPast = false;
    this.click = false;
    this.w = img.width;
    this.h = img.height;
    this.x = x;
    this.y = y - h / 2;
    this.button = new Button("done", 630, 660, 50, 30);
  }

  void message() {
    pushStyle();
    imageMode(CENTER);
    // "help me" speech bubble if not completed and player has walked past
    if (walkedPast && !complete) {
      image(help, this.x - this.w / 1.4, this.y - this.h / 2);
    }
    //"thank you" speech bubble
    if (complete) {
      image(thankYou, this.x - this.w / 1.4, this.y - this.h / 2);
    }
    popStyle();
  }

  void render() {
    //display the circuit game
    if (displayCircuit) {
      this.circuit.run();
      //done button
      button.render();
    } else {
      //render the robot
      pushStyle();
      imageMode(CENTER);
      
      //render speech bubble if any
      message();
      
      //robot image
      if (complete) {
        image(img, x, y);
      } else {
        image(dead, x, y);
      }
      popStyle();
    }
  }

  // has the player walked past this robot
  void walkedPast(int pos) {
    if (pos > this.x - 150) {
      walkedPast = true;
    }
  }
  
  void mouseR() {
    //offset for clicking
    float offset;
    if (p1.x < width / 2) {
      offset = 0;
    } else if (p1.x < 4000 - width / 2) {
      offset = -p1.x + width / 2;
    } else {
      offset = width - 4000;
    }

    if (displayCircuit) {
      //if clicked done button
      if (mouseX > button.x - button.w / 2 && mouseX < button.x + button.w / 2
        && mouseY > button.y - button.h / 2 && mouseY < button.y + button.h / 2) {
        // check completion
        this.complete = this.circuit.complete;
        this.click = false;
        this.displayCircuit = false;
      }

      //send click to circuit
      this.circuit.mouseR();
    } else {
      if (mouseX > x - w / 2 + offset 
        && mouseX < x + w / 2 + offset
        && mouseY > y - h / 2 && mouseY < y + h / 2) {
        click = true;
        if (click && !complete) {
          displayCircuit = true;
        }
      }
    }
  }

  void mouseP() {
    if (displayCircuit) {
      this.circuit.mouseP();
    }
  }
}

// represents a button with a word in a box
class Button {
  int x, y, w, h;
  String word;

  Button(String word, int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.word = word;
  }

  void render() {
    pushStyle();
    noFill();
    stroke(0, 250, 255);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, w, h);
    fill(0, 250, 255);
    textAlign(CENTER);
    textFont(font10);
    text(word, x, y + 5);
    popStyle();
  }
}