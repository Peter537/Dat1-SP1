class Replay {
  
  private IntList xList, yList;
  private Apple apple;
  private int score;

  public Replay(IntList xList, IntList yList, Apple apple, int score) {
    this.xList = xList;
    this.yList = yList;
    this.apple = apple;
    this.score = score;
  }

  Apple getApple() {
    return apple;
  }

  IntList getXList(){
    return xList;
  }

  IntList getYList(){
    return yList;
  }
  
  int getScore() {
    return score;
  }
  
  // Methods
  
  void drawMap() {
    drawApple();
    drawSnake();
  }
  
  void drawApple() {
    fill(210, 0, 0);
    //circle(getAppleX(), getAppleY(), FIELD_SIZE / 2);
    circle(getApple().getX(), getApple().getY(), 40 / 2); // FJERNE HARDCODED
  }
  
  void drawSnake() {
    fill(0, 180, 0);
    for (int i = 0; i < getXList().size(); i++){
      //circle(getXList().get(i), getYList().get(i), FIELD_SIZE);
      circle(getXList().get(i), getYList().get(i), 40); // FJERNE HARDCODED...
    }
    drawSnakeHead(getXList().get(0), getYList().get(0));
  }
  
  void drawSnakeHead(int x, int y){
    fill(0);
    strokeWeight(5);
    point(x - 5, y - 5);
    point(x + 5, y - 5);
    ellipse(x, y + 10, 10, 3);
    strokeWeight(1);
  }
}
