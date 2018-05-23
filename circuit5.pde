class Circuit5 extends Circuit { 
  Circuit5() {
    initialize();
  }

  void initialize() {
    this.solution = new String[]{"and", "not", "or"};
    this.gatePositions = new Posn[]{new Posn(width / 2.5, height / 2.65), 
      new Posn(width / 2.5, height / 1.6), 
      new Posn( width / 1.6, height / 2)};
    this.sources = new boolean[]{false, false, false}; // true for on, false for off
    this.complete = false;
    this.inputGates = new String[3];
    this.gates = new Gate[]{new Gate("and", 175, 600, 50, 50), 
      new Gate("or", 350, 600, 50, 50), new Gate("not", 525, 600, 50, 50)};
  }

  void renderLines() {
    pushStyle();
    stroke(0, 250, 255);
    strokeWeight(2);

    line(100, 175, 175, 175);
    line(175, 175, 175, 243);
    line(175, 243, 255, 243);

    line(100, 350, 175, 350);
    line(175, 350, 175, 283);
    line(175, 283, 255, 283);

    line(100, 525, 175, 525);
    line(175, 525, 175, 435);
    line(175, 435, 255, 435);

    line(305, 265, 350, 265);
    line(350, 265, 350, 330);
    line(350, 330, 411, 330);

    line(305, 435, 350, 435);
    line(350, 435, 350, 370);
    line(350, 370, 411, 370);

    line(462, 350, 600, 350);
    popStyle();
  }
}