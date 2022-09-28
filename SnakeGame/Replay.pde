class Replay {
  
  // Fields
  
  private IntList xList, yList;
  private int score;
  private int FIELD_SIZE = 40;

  private Apple apple;

  // Constructors
  
  public Replay(IntList xList, IntList yList, Apple apple, int score) {
    this.xList = xList;
    this.yList = yList;
    this.apple = apple;
    this.score = score;
  }
  
  // Methods

  void drawMap() {
    drawApple();
    drawSnake();
  }
  
  void drawApple() {
    fill(210, 0, 0);
    circle(getApple().getX(), getApple().getY(), FIELD_SIZE / 2);
  }
  
  void drawSnake() {
    fill(0, 180, 0);
    for (int i = 0; i < getXList().size(); i++){
      circle(getXList().get(i), getYList().get(i), FIELD_SIZE);
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
  
  // Getters

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
}
