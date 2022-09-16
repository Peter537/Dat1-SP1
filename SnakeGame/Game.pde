class Game {
 
  int frames = 0;
  int score = 0;
  IntList snakeXList = new IntList();
  IntList snakeYList = new IntList();
  int appleX = -1, appleY = -1;
  boolean hasEatenApple = true;
  boolean gameEnded = false;
  
  // fjerne hardcoded størrelse på felterne, og lave en variabel
  int FIELDS = 15;
  int FIELD_SIZE = 40;
  
  ArrayList<Replay> replays = new ArrayList<Replay>();
  int currentReplayIndex = 0;
  
  String gameState = "Menu";
  
  Snake snake;

  
  public Game() {
    //replays = new ArrayList<Replay>();
    //FIELDS = 15;
    //FIELD_SIZE = 40;
    //gameState = "Menu";
    size(600, 640);
    background(210);
    setupGame(gameState);
    frameRate(120);
    snake = new Snake();
  }
  
  
  
  
  void drawMap() {
    
  }
  



  void setupGame(String state){
    switch (state){
      case "Menu":
        background(210);
        textSize(30);
        text("Klik på knappen for at starte spillet", 100, 70);
        fill(0, 0, 180);
        rect(100, 100, width - 200, height - 300);
        break;
      case "Game":
        background(210);
        createLayer();
        createAppleCoords();
        fill(0, 180, 0);
        snake.getXList().set(0, FIELD_SIZE / 2);
        snake.getYList().set(0, FIELD_SIZE / 2);
        replays.add(new Replay(snake.getXList().copy(), snake.getYList().copy(), appleX, appleY));
        snake.drawSnake();
        break;
      case "End":
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
      case "Replay":
        showReplay(0);
        break;
      default:
        break;
    }
  }





  boolean hasEatenApple(){
    return (appleX == snake.getXList().get(0) && appleY == snake.getYList().get(0));
  }
  
  void createAppleCoords(){
    // lave noget som tjekker om det er inde i Snaken
    appleX = ((int) random(FIELDS)) * FIELD_SIZE + 20;
    appleY = ((int) random(FIELDS)) * FIELD_SIZE + 20;
  }
  
  // ændre til createBackground() og så tilføje nederste linje
  void createLayer(){
    noFill();
    for (int x = 0; x < FIELDS * FIELD_SIZE; x += FIELD_SIZE) {
      for (int y = 0; y < FIELDS * FIELD_SIZE; y += FIELD_SIZE){
        rect(x, y, FIELD_SIZE, FIELD_SIZE);
      }
    }
    fill(255);
    rect(0, height - FIELD_SIZE, width, height);
  }



  void showReplay(int index) {
    //println("Current Replay:" + index);
    background(210);
    createLayer();
    fill(180, 0, 0);
    rect(20, FIELDS * FIELD_SIZE + 3, 60, 34);
    fill(0, 180, 0);
    rect(20 + 80, FIELDS * FIELD_SIZE + 3, 60, 34);
    Replay r = replays.get(index);
    r.drawMap();
    //fill(210, 0, 0);
    //circle(r.getAppleX(), r.getAppleY(), FIELD_SIZE / 2);
    //r.drawSnake();
    //drawReplaySnake(r);
  }


  boolean isInsideRect(float rcx, float rcy, float w, float h, float px, float py){
    return isInRange(rcx, rcx + w, px) && isInRange(rcy, rcy + h, py);
  }
  
  boolean isInRange(float begin, float end, float value){
    return (begin <= value && value <= end);
  }

  
}
