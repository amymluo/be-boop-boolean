class Circuit3 extends Circuit {

  Circuit3() {
    initialize();
  }

  void initialize() {
    this.solution = new String[]{"or"};
    this.gatePositions = new Posn[]{new Posn(width / 2, height / 2)};
    this.sources = new boolean[]{true, false}; // true for on, false for off
    this.complete = false;
    this.inputGates = new String[1];
    this.gates = new Gate[]{new Gate("and", 175, 600, 50, 50), 
      new Gate("or", 350, 600, 50, 50), new Gate("not", 525, 600, 50, 50)};
  }
  
  void renderLines() {
    pushStyle();
    stroke(0, 250, 255);
    strokeWeight(2);
    line(100, 233, 250, 233);
    line(100, 466, 250, 466);
    
    line(250, 233, 250, 330);
    line(250, 466, 250, 370);
    
    line(250, 330, 325, 330);
    line(250, 370, 325, 370);
    
    line(375, 350, 600, 350);
    popStyle();
  }
}