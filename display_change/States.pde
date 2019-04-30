class TitleState extends State {
  void drawState() {
    text("Game Title", width * 0.5, height * 0.3);
    text("Press 'z' key to start", width * 0.5, height * 0.7);
  }

  State decideState() {
    if (keyPressed && key == 'z') { // if 'z' key is pressed
      return new GameState(); // start game
    }
    return this;
  }
}

class GameState extends State {
  void drawState() {
    text("Game (for 5 seconds)", width * 0.5, height * 0.5);
  }

  State decideState() {
    if (t > 5) { // if ellapsed time is larger than
      return new EndingState(); // go to ending
    } 
    return this;
  }
}

class EndingState extends State {
  void drawState() {
    text("Ending", width * 0.5, height * 0.5);
    if (t > 3) {
      text("Press 'a' to restart.", width * 0.5, height * 0.7);
    }
  }

  State decideState() {
    if (t > 3 && keyPressed && key == 'a') {
      return new EndingState();
    }
    return this;
  }
}
