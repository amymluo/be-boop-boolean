class Circuit6 extends Circuit { 
  Circuit6() {
    initialize();
  }

  void initialize() {
    this.solution = new String[]{"or", "and", "not", "or"};
    this.gatePositions = new Posn[]{new Posn(width / 2.4, height / 3.4), 
      new Posn(width / 3, height / 1.45), 
      new Posn(width / 2, height / 1.45), 
      new Posn( width / 1.45, height / 2)};
    this.sources = new boolean[]{true, false, true, true}; // true for on, false for off
    this.complete = false;
    this.inputGates = new String[4];
    this.gates = new Gate[]{new Gate("and", 140, 625, 50, 50), 
      new Gate("or", 280, 625, 50, 50), new Gate("or", 420, 625, 50, 50), 
      new Gate("not", 560, 625, 50, 50) };
  }

  void renderLines() {
    pushStyle();
    stroke(0, 250, 255);
    strokeWeight(2);

    line(100, 140, 175, 140);
    line(175, 140, 175, 185);
    line(175, 185, 265, 185);

    line(100, 280, 175, 280);
    line(175, 280, 175, 225);
    line(175, 225, 265, 225);

    line(100, 560, 175, 560);
    line(175, 560, 175, 505);
    line(175, 505, 206, 505);

    line(100, 425, 175, 425);
    line(175, 425, 175, 460);
    line(175, 460, 206, 460);

    line(318, 205, 400, 205);
    line(400, 205, 400, 330);
    line(400, 330, 457, 330);

    line(375, 480, 400, 480);
    line(400, 480, 400, 370);
    line(400, 370, 457, 370);
    
    line(260, 480, 325, 480);

    line(507, 350, 600, 350);
    popStyle();
  }
}