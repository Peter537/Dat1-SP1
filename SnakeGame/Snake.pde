class Snake {
  private IntList xList, yList;

  /*
  private String direction = "RIGHT";
  private String newDirection = "RIGHT";
  */

  private Direction direction = Direction.RIGHT;
  private Direction newDirection = Direction.RIGHT;

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
  
  /*
  String getDirection() {
    return direction;
  }

  String getNewDirection() {
    return newDirection;
  }
  */
  
  Direction getDirection() {
    return direction;
  }

  Direction getNewDirection() {
    return newDirection;
  }

  /*
  void setNewDirection(String newDirection) {
    this.newDirection = newDirection;
  }

  void setDirection(String direction) {
    this.direction = direction;
  }
  */
  
  void setNewDirection(Direction newDirection) {
    this.newDirection = newDirection;
  }

  void setDirection(Direction direction) {
    this.direction = direction;
  }
  
  // Metoden vil indeholde alt om at opdatere X og Y coords
  void updateSelf() {
    switch (getDirection()){
      case RIGHT:
        getXList().set(0, getXList().get(0) + 40); // 40 == FIELD_SIZE, FJERNE HARDCODED
        break;
      case LEFT:
        getXList().set(0, getXList().get(0) - 40); // 40 == FIELD_SIZE, FJERNE HARDCODED
        break;
      case UP:
        getYList().set(0, getYList().get(0) - 40); // 40 == FIELD_SIZE, FJERNE HARDCODED
        break;
      case DOWN:
        getYList().set(0, getYList().get(0) + 40); // 40 == FIELD_SIZE, FJERNE HARDCODED
        break;
      default:
        break;
    }
  }
  
  
  void update() {    
    for (int i = getXList().size() - 1; i > 0; i--){
      getXList().set(i, getXList().get(i - 1));
      getYList().set(i, getYList().get(i - 1));
    }
  }


  // Methods
  void drawSnake(){
    fill(0, 180, 0);
    for (int i = 0; i < xList.size(); i++){
      circle(xList.get(i), yList.get(i), 40); // 40 == FIELD_SIZE, FJERNE HARDCODED
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
