import garciadelcastillo.dashedlines.*;
import processing.sound.*;

DashedLines dash;
SoundFile bgMusic;
SoundFile bing;

//list of npc robots
ArrayList<NPC> npcs;

//player
Player p1;

//images
PImage walk1Right, standRight, walk2Right, walk1Left, standLeft, walk2Left;

//screen images
PImage bg, titleScreen, infoScreen, endScreen, hints;

int screen; // which screen you are on, 0 for title, 1 for info, 3+ for game
boolean gameOver; // is the game over?

//gate images
PImage not, and, or;
// speech bubbles
PImage help, thankYou;

//robot images
PImage robot1, robot2, robot3, robot4, robot5, robot6;
PImage robot1Dead, robot2Dead, robot3Dead, robot4Dead, robot5Dead, robot6Dead;

//should a circuit be displayed?
// should the hints be displayed?
boolean circuit, showHints;

//fonts
PFont font10, font15, sourceFont;

void setup() {
  size(700, 700);
  dash = new DashedLines(this);
  dash.pattern(10, 5);

  //fonts
  font10 = createFont("pcsenior.ttf", 10);
  font15 = createFont("pcsenior.ttf", 15);
  sourceFont = createFont("Avenir.ttc", 20);

  //sounds
  bgMusic = new SoundFile(this, "bgMusic.wav");
  bing = new SoundFile(this, "bing.mp3");

  //player walking sprites
  walk1Right = loadImage("data/player_walking1_right.png");
  standRight = loadImage("data/player_stand_right.png");
  walk2Right = loadImage("data/player_walking2_right.png");
  walk1Left = loadImage("data/player_walking1_left.png");
  standLeft = loadImage("data/player_stand_left.png");
  walk2Left = loadImage("data/player_walking2_left.png");

  //speech bubbles
  help = loadImage("data/help.png");
  thankYou = loadImage("data/thank you.png");

  //screens
  bg = loadImage("data/bg.jpg");
  titleScreen = loadImage("data/title.png");
  infoScreen = loadImage("data/info.png");
  endScreen = loadImage("data/endScreen.png");
  hints = loadImage("data/hints.png");

  //logic gates
  not = loadImage("data/not.png");
  and = loadImage("data/and.png");
  or = loadImage("data/or.png");

  //robot images
  robot1 = loadImage("data/robots/robot1.png");
  robot2 = loadImage("data/robots/robot2.png");
  robot3 = loadImage("data/robots/robot3.png");
  robot4 = loadImage("data/robots/robot4.png");
  robot5 = loadImage("data/robots/robot5.png");
  robot6 = loadImage("data/robots/robot6.png");

  //robot no power images
  robot1Dead = loadImage("data/robots/robot1_dead.png");
  robot2Dead = loadImage("data/robots/robot2_dead.png");
  robot3Dead = loadImage("data/robots/robot3_dead.png");
  robot4Dead = loadImage("data/robots/robot4_dead.png");
  robot5Dead = loadImage("data/robots/robot5_dead.png");
  robot6Dead = loadImage("data/robots/robot6_dead.png");

  //initializing npc list
  npcs = new ArrayList<NPC>();
  npcs.add(new NPC(robot1, robot1Dead, new Circuit1(), 500, 590));
  npcs.add(new NPC(robot6, robot6Dead, new Circuit2(), 1100, 590));
  npcs.add(new NPC(robot4, robot4Dead, new Circuit3(), 1700, 590));
  npcs.add(new NPC(robot5, robot5Dead, new Circuit4(), 2300, 590));
  npcs.add(new NPC(robot2, robot2Dead, new Circuit5(), 2900, 590));
  npcs.add(new NPC(robot3, robot3Dead, new Circuit6(), 3500, 590));
  p1 = new Player(10, 590, walk1Right, standRight, walk2Right, 
    walk1Left, standLeft, walk2Left);

  //other global variables
  bgMusic.loop();
  screen = 0;
  gameOver = false;
}

void draw() {
  //screens
  if (screen == 0) {
    background(titleScreen);
  } else if (screen == 1) {
    background(infoScreen);
  } else if (gameOver) {
    background(endScreen);
  } else {
    //-------------actual game----------------
    //checking if game is completed
    isGameOver();
    background(197);

    //checking if circuit should be rendered
    circuit = false;
    for (NPC n : npcs) {
      if (n.displayCircuit) {
        circuit = true;
        n.render();
        //hints during circuit game
        textFont(font10);
        fill(255);
        text("Press i for hints", 500, 25);

        // show hints during circuit game
        if (showHints) {
          pushStyle();
          imageMode(CENTER);
          image(hints, width / 2, height / 2); 
          popStyle();
        }
        break;
      }
    }

    //if no circuit, player with robots rendered
    if (!circuit) {
      //calculating offset of screen
      pushStyle();
      float offset;
      if (p1.x < width / 2) {
        offset = 0;
      } else if (p1.x < 4000 - width / 2) {
        offset = -p1.x + width / 2;
      } else {
        offset = width - 4000;
      }

      //rendering player and npcs
      translate(offset, 0);
      image(bg, 0, 0);
      for (NPC n : npcs) {
        if (!n.walkedPast) {
          n.walkedPast(p1.x);
        }
        n.render();
      }
      p1.render();

      //hints during walking sequence
      textFont(font10);
      fill(255);
      text("Press i for hints", 500 + -offset, 25);
      text("<- -> keys to move", 25, 610);
      text("Click robots to help", 25, 635);

      if (showHints) {
        imageMode(CENTER);
        image(hints, width / 2 + -offset, height / 2);
      }
      popStyle();
    }
  }
}

//checks if the game is over
void isGameOver() {
  boolean allComplete = true;
  for (NPC n : npcs) {
    allComplete = allComplete && n.complete;
  }
  gameOver = allComplete && p1.x > 3950;
}

//restarts the game
void restart() {
  bgMusic.stop();
  npcs = new ArrayList<NPC>();
  npcs.add(new NPC(robot1, robot1Dead, new Circuit1(), 500, 590));
  npcs.add(new NPC(robot2, robot2Dead, new Circuit2(), 1100, 590));
  npcs.add(new NPC(robot3, robot3Dead, new Circuit3(), 1700, 590));
  npcs.add(new NPC(robot4, robot4Dead, new Circuit4(), 2300, 590));
  npcs.add(new NPC(robot5, robot5Dead, new Circuit5(), 2900, 590));
  npcs.add(new NPC(robot6, robot6Dead, new Circuit6(), 3500, 590));
  p1 = new Player(10, 590, walk1Right, standRight, walk2Right, 
    walk1Left, standLeft, walk2Left);
  bgMusic.loop();
  screen = 0;
  gameOver = false;
  showHints = false;
}

//send the mouse press to the npc if within range of robot
void mousePressed() {
  for (NPC n : npcs) {
    if (p1.x > n.x - 150 && p1.x < n.x + 150) {
      n.mouseP();
      break;
    }
  }
}

//send the mouse release to the npc if within range of robot
void mouseReleased() {
  for (NPC n : npcs) {
    if (p1.x > n.x - 150 && p1.x < n.x + 150) {
      n.mouseR();
      break;
    }
  }
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    screen ++;
  } else if (key == 'r' || key == 'R') {
    restart();
  } else if (key == 'i' || key == 'I') {
    showHints = !showHints;
  } else {
    p1.onKey();
  }
}