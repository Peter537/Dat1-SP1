class Game {

  private boolean gameEnded = false;
  private boolean isAutoReplay = false;
  
  private int score = 0;
  private int FIELDS = 15;
  private int FIELD_SIZE = 40;
  private int currentReplayIndex = 0;
  
  private ArrayList<Replay> replays = new ArrayList<Replay>();
  
  private GameState gameState = GameState.MENU;
  private Snake snake;
  private Apple apple;
  
  public Game() {
    background(210);
    setupGame(gameState);
    snake = new Snake();
  }
  


  void drawMap() {
    background(210);
    createBackground();
    if (hasEatenApple()) {
      createApple();
    }
    drawApple();
    snake.drawSnake();
    drawScore();
  }


  void setupGame(GameState state){
    switch (state){
      case MENU:
        background(210);
        textSize(30);
        text("Klik på knappen for at starte spillet", 100, 70);
        fill(0, 0, 180);
        rect(100, 100, width - 200, height - 300);
        break;
      case GAME:
        background(210);
        createBackground();
        createApple();
        fill(0, 180, 0);
        snake.getXList().set(0, FIELD_SIZE / 2);
        snake.getYList().set(0, FIELD_SIZE / 2);
        replays.add(new Replay(snake.getXList().copy(), snake.getYList().copy(), apple, score));
        snake.drawSnake();
        break;
      case END:
        background(210);
        fill(180, 0, 0);
        textSize(30);
        text("You died... Score: " + score, 100, 70);
        /*
        // Bruge Game objekt til at lave nye Games
        fill(0, 0, 180);
        rect(100, 100, width - 200, height - 300);
        */
        // REPLAY SYSTEM
        fill(0, 0, 180);
        rect(100, 100, width - 200, height - 300);
        break;
      case REPLAY:
        showReplay("right");
        break;
      default:
        break;
    }
  }

  
  void createApple() {
    snake.getXList().set(snake.getXList().size(), apple != null ? apple.getX() : -1);
    snake.getYList().set(snake.getYList().size(), apple != null ? apple.getY() : -1);
    score += 1;

    // lave noget som tjekker om det er inde i Snaken
    int appleX = ((int) random(FIELDS)) * FIELD_SIZE + 20;
    int appleY = ((int) random(FIELDS)) * FIELD_SIZE + 20;
    apple = new Apple(appleX, appleY);
  }
  
  // ændre til createBackground() og så tilføje nederste linje
  void createBackground(){
    noFill();
    for (int x = 0; x < FIELDS * FIELD_SIZE; x += FIELD_SIZE) {
      for (int y = 0; y < FIELDS * FIELD_SIZE; y += FIELD_SIZE){
        rect(x, y, FIELD_SIZE, FIELD_SIZE);
      }
    }
    fill(255);
    rect(0, height - FIELD_SIZE, width, height);
  }

  void drawApple(){
    fill(210, 0, 0);
    circle(apple.getX(), apple.getY(), FIELD_SIZE / 2);
  }
  
  void drawScore(){
    fill(127, 0, 127);
    textSize(30);
    text("Score: " + score, width / 2 - FIELD_SIZE, FIELDS * FIELD_SIZE + FIELD_SIZE * 0.75);
  }
  
  void checkAndUpdateDirection() {
    if (getSnake().getNewDirection() != getSnake().getDirection()) {
      getSnake().setDirection(getSnake().getNewDirection());
    }
  }
  
  void setGameState(GameState gameState) {
    this.gameState = gameState;
  }
  
  void setEnded(boolean b) {
    this.gameEnded = b;
  }
  
  void setAutoReplay(boolean b) {
    this.isAutoReplay = b;
  }

  boolean hasGameEnded() {
    return gameEnded;
  }

  boolean hasHitBorder(){
    return snake.getXList().get(0) < 0 || snake.getXList().get(0) > (FIELDS * FIELD_SIZE) || snake.getYList().get(0) < 0 || snake.getYList().get(0) > (FIELDS * FIELD_SIZE);
  }
  
  boolean hasHitSnake() {
    return false;
    /*
      // Skal lige have fikset det her
      println("New Run");
      for (int x = 2; x < snakeXList.size() - 1; x++) {
        for (int y = 2; y < snakeXList.size() - 1; y++) {
          println("x:" + x + ": " + snakeXList.get(x) + " = " + snakeXList.get(0));
          println("y:" + y + ": " + snakeYList.get(y) + " = " + snakeYList.get(0));
          if (snakeXList.get(0) == snakeXList.get(x) && snakeYList.get(0) == snakeYList.get(y)) {
            println("true");
            //gameEnded = true;
            //return;
          }
        }
      }
    }*/
  }

  boolean hasEatenApple(){
    return (apple.getX() == snake.getXList().get(0) && apple.getY() == snake.getYList().get(0));
  }
  
  boolean isAutoReplay() {
    return isAutoReplay;
  }
  
  GameState getGameState() {
    return gameState;
  }

  Snake getSnake() {
    return snake;
  }
  
  
  
  // --------------
  // REPLAY SYSTEM
  //

  void addReplay() {
    replays.add(new Replay(snake.getXList().copy(), snake.getYList().copy(), apple, score));
  }
  
  // String s will be 'back' or 'forward'
  void showReplay(String s) {
    if (s.equalsIgnoreCase("forward")) {
      if (getReplays().size() <= (currentReplayIndex + 2)){
        isAutoReplay = false;
        println("not set");
        return;
      }
      currentReplayIndex++;
    } else if (s.equalsIgnoreCase("back")) {
      if (0 > (currentReplayIndex - 1)){
        isAutoReplay = false;
        println("not set");
        return;
      }
      currentReplayIndex--;
    }

    // CREATING BACK LAYER..
    background(210);
    createBackground();
    // Red box to go back
    fill(180, 0, 0);
    rect(20, FIELDS * FIELD_SIZE + 3, 60, 34);
    // Green box to go forwards
    fill(0, 180, 0);
    rect(20 + 80, FIELDS * FIELD_SIZE + 3, 60, 34);
    // Automatisk frem
    fill(0, 0, 180);
    rect(20 + 160, FIELDS * FIELD_SIZE + 3, 60, 34);

    Replay r = replays.get(currentReplayIndex);
    r.drawMap();

    fill(127, 0, 127);
    textSize(30);
    text("Score: " + r.getScore(), width / 2 - FIELD_SIZE, FIELDS * FIELD_SIZE + FIELD_SIZE * 0.75);
  }
  
  ArrayList<Replay> getReplays() {
    return replays;
  }
}
