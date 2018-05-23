class Circuit4 extends Circuit {

  Circuit4() {
    initialize();
  }

  void initialize() {
    this.solution = new String[]{"and", "not"};
    this.gatePositions = new Posn[]{new Posn(width / 2.5, height / 2), 
      new Posn( width / 1.6, height / 2)};
    this.sources = new boolean[]{true, false}; // true for on, false for off
    this.complete = false;
    this.inputGates = new String[2];
    this.gates = new Gate[]{new Gate("and", 175, 600, 50, 50), 
      new Gate("or", 350, 600, 50, 50), new Gate("not", 525, 600, 50, 50)};
  }

  void renderLines() {
    pushStyle();
    stroke(0, 250, 255);
    strokeWeight(2);
    line(100, 233, 175, 233);
    line(100, 466, 175, 466);

    line(175, 233, 175, 330);
    line(175, 466, 175, 370);

    line(175, 330, 255, 330);
    line(175, 370, 255, 370);

    line(305, 350, 411, 350);
    line(462, 350, 600, 350);
    popStyle();
  }
}