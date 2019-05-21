State state;

void setup() {
  size(400, 400);
  textSize(32);
  textAlign(CENTER);
  fill(255);
  state = new TitleState();
}

void draw() {
  background(0);
  state = state.doState();
}

abstract class State {
  long t_start;
  float t;

  State() {
    t_start = millis();
  }

  State doState() {
    t = (millis() - t_start) / 1000.0;
    text(nf(t, 1, 3)  + "sec.", width * 0.5, height * 0.9);
    drawState();
    return decideState();
  }

  abstract void drawState();    // 状態に応じた描画を行う
  abstract State decideState(); // 次の状態を返す
}
