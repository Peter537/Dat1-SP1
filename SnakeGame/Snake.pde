class Snake {

  // Fields
  
  private IntList xList, yList;
  private int FIELD_SIZE = 40;

  private Direction direction = Direction.RIGHT;
  private Direction newDirection = Direction.RIGHT;

  // Constructors

  public Snake() {
    xList = new IntList();
    yList = new IntList();
  }
  
  // Methods

  void updateSelf() {
    switch (getDirection()){
      case RIGHT:
        getXList().set(0, getXList().get(0) + FIELD_SIZE);
        break;
      case LEFT:
        getXList().set(0, getXList().get(0) - FIELD_SIZE);
        break;
      case UP:
        getYList().set(0, getYList().get(0) - FIELD_SIZE);
        break;
      case DOWN:
        getYList().set(0, getYList().get(0) + FIELD_SIZE);
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

  void drawSnake() {
    fill(0, 180, 0);
    for (int i = 0; i < xList.size(); i++){
      circle(xList.get(i), yList.get(i), FIELD_SIZE);
    }
    drawSnakeHead(xList.get(0), yList.get(0));
  }

  void drawSnakeHead(int x, int y) {
    fill(0);
    strokeWeight(5);
    point(x - 5, y - 5);
    point(x + 5, y - 5);
    ellipse(x, y + 10, 10, 3);
    strokeWeight(1);
  }
  
  // Getters
  
  IntList getXList() {
    return xList;
  }

  IntList getYList() {
    return yList;
  }
  
  Direction getDirection() {
    return direction;
  }

  Direction getNewDirection() {
    return newDirection;
  }

  // Setters

  void setNewDirection(Direction newDirection) {
    this.newDirection = newDirection;
  }

  void setDirection(Direction direction) {
    this.direction = direction;
  } 
}
