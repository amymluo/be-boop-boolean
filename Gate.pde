//represents a logic gate: and, or, not
class Gate {
  String type; // and, or, not
  int x, y, w, h; // position on screen
  boolean pressed;
  Posn snap; // position to snap to if collide
  boolean collide;

  Gate(String type, int x, int y, int w, int h) {
    if (!(type.equals("and") || type.equals("or") || type.equals("not"))) {
      throw new IllegalArgumentException("invalid gate");
    }
    this.type = type;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.collide = false;
    this.snap = null;
  }

  void render() {
    pushStyle();
    imageMode(CENTER);
    switch (type) {
    case "not": 
      image(not, x, y, 75, 75);
      break;
    case "and":
      image(and, x, y, 75, 75);
      break;
    case "or":
      image(or, x, y, 75, 75);
      break;
    }
    popStyle();
  }

  //updates position of gate to mouse position if pressed/dragged
  void update() {
    if (pressed) {
      this.x = mouseX;
      this.y = mouseY;
    }
  }

  // is the mouse over this gate?
  boolean isMouseOver() {
    return mouseX > x - w / 2 && mouseX < x + w / 2
      && mouseY > y - h / 2 && mouseY < y + h / 2;
  }
}