//represents a circuit game to complete
abstract class Circuit {

  String[] inputGates;
  String[] solution; // correct gates
  Posn[] gatePositions; // collision point for gates
  boolean[] sources; // true for on, false for off
  boolean complete;
  Gate[] gates; // gate options

  abstract void initialize();

  void run() {
    background(50);

    //title text
    pushStyle();
    textAlign(CENTER);
    fill(255);
    textFont(font15);
    text("Complete the circuit!", 100, 75, 500, 200);
    textFont(font10);
    text("Drag the correct gates", width / 2, 675);
    popStyle();

    //render everything
    render();

    //gate dragging
    for (Gate g : gates) {
      g.update();
    }

    // check for collision/completion every frame
    checkCollision();
    checkComplete();
  }

  void checkCollision() {
    for (Gate g : gates) {
      g.collide = false;
    }
    for (int i = 0; i < gatePositions.length; i ++) {
      Posn p = gatePositions[i];
      boolean collide = false;
      for (Gate g : gates) {
        if (!g.collide) {
          if (p.x > g.x - g.w / 2 && p.x < g.x + g.w / 2 
            && p.y > g.y - g.h / 2 && p.y < g.y + g.h / 2) {
            inputGates[i] = g.type;
            collide = true;
            g.collide = true;
            g.snap = gatePositions[i];
          }
        }
      }
      if (!collide) {
        inputGates[i] = null;
      }
    }
  }

  void checkComplete() {
    boolean result = true;
    for (int i = 0; i < solution.length; i ++) {
      result = result && solution[i].equals(inputGates[i]);
    }
    boolean oldComplete = complete;
    complete = result;
    if ((complete != oldComplete) && complete) {
      bing.play();
    }
  }

  void render() {
    pushStyle();
    renderLines();
    renderLightbulb();
    renderSources();
    renderGatePosns();
    renderGates();
    popStyle();
  }


  void renderLightbulb() {
    pushStyle();
    if (complete) {
      noStroke();
      fill(255, 255, 0, 10);
      ellipse(600, height / 2, 120, 120);
      fill(255, 255, 0, 20);
      ellipse(600, height / 2, 90, 90);
      fill(255, 255, 0);
    } else {
      stroke(0, 250, 255);
      strokeWeight(2);
      fill(50);
    }
    ellipse(600, height / 2, 70, 70);
    popStyle();
  }

  void renderSources() {
    pushStyle();
    int spacing = height / (sources.length + 1);
    for (int i = 0; i < sources.length; i ++ ) {
      textAlign(CENTER);
      rectMode(CENTER);
      textFont(sourceFont);
      noStroke();
      if (sources[i]) { // on source
        //on rings
        fill(255, 10);
        noStroke();
        ellipse(100, (i + 1) * spacing, 100, 100);
        fill(255, 20);
        ellipse(100, (i + 1) * spacing, 75, 75);
        fill(255);

        ellipse(100, (i + 1) * spacing, 50, 50);
        fill(0);

        text("on", 100, (i + 1) * spacing + 5);
      } else { // off
        fill(0);
        ellipse(100, (i + 1) * spacing, 50, 50);
        fill(255);
        text("off", 100, (i + 1) * spacing + 5);
      }
    }
    popStyle();
  }

  void renderGatePosns() {
    pushStyle();
    rectMode(CENTER);
    noFill();
    stroke(0, 250, 255);
    strokeWeight(2);
    for (Posn p : gatePositions) {
      dash.rect(p.x, p.y, 50, 50);
    }
    popStyle();
  }

  void renderGates() {
    for (Gate g : gates) {
      g.render();
    }
  }

  abstract void renderLines();

  void mouseP() {
    for (Gate g : gates) {
      g.pressed = g.isMouseOver();
      if (g.pressed) {
        break;
      }
    }
  }

  void mouseR() {
    for (Gate g : gates) {
      g.pressed = false;
      if (g.collide) {
        g.x = (int)g.snap.x;
        g.y = (int)g.snap.y;
      }
    }
  }
}