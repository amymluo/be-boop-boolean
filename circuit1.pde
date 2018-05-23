class Circuit1 extends Circuit {

  Circuit1() {
    initialize();
  }

  void initialize() {
    this.solution = new String[]{"not"};
    this.gatePositions = new Posn[]{new Posn(width / 2, height / 2)};
    this.sources = new boolean[]{false}; // true for on, false for off
    this.complete = false;
    this.inputGates = new String[1];
    this.gates = new Gate[]{new Gate("and", 175, 600, 50, 50), 
      new Gate("or", 350, 600, 50, 50), new Gate("not", 525, 600, 50, 50)};
  }

  void renderLines() {
    pushStyle();
    stroke(0, 250, 255);
    strokeWeight(2);
    line(100, 350, 325, 350);
    line(375, 350, 600, 350);
    popStyle();
  }
}