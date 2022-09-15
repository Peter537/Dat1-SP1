class Snake {
  private IntList xList, yList;

  private String direction = "RIGHT";
  private String newDirection = "RIGHT";

  public Snake() {
    xList = new IntList();
    yList = new IntList();
  }
  
  IntList getXList(){
    return xList;
  }

  IntList getYList(){
    return yList;
  }
  
  String getDirection() {
    return direction;
  }

  String getNewDirection() {
    return newDirection;
  }

  void setNewDirection(String newDirection) {
    this.newDirection = newDirection;
  }

  void setDirection(String direction) {
    this.direction = direction;
  }


  // Methods
  void drawSnake(){
    fill(0, 180, 0);
    for (int i = 0; i < xList.size(); i++){
      circle(xList.get(i), yList.get(i), FIELD_SIZE);
    }
    drawSnakeHead(xList.get(0), yList.get(0));
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