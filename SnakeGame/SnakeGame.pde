// TODO:
//  - Game klasse som har det hele i sig, så man kan have flere games i stedet
//    for at skulle restart hvor den stadig gemmer replay etc.
//  - Bruge flere 'Tabs' som klasser i Processing, så det i flere filer
//  - I replay system, tilføje så man kan gøre så det automatisk kører frem/tilbage ved X frames
//  - Idk om jeg laver Direction ENUM eller om jeg bruger 'key' i mousePressed, har gjort klar til ENUM'et
//    eller bruge HashMap<int(key), String> som parser en key til RIGHT, LEFT, UP el. DOWN
//  - Gjort klar til at kunne bruge Game objectet til at lave flere games
//  - GameState ENUM? GameState.MENU, GAME, END, REPLAY?


// String[] direction? hvor [0] = currentDirection & [1] = newDirection
//String direction = "RIGHT";
//String newDirection = "RIGHT";
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

void setup(){
  //replays = new ArrayList<Replay>();
  //FIELDS = 15;
  //FIELD_SIZE = 40;
  //gameState = "Menu";
  size(600, 640); // Skal forblive
  background(210);
  setupGame(gameState);
  frameRate(120);  // Skal forblive
  snake = new Snake();
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


/*
// Når Game klassen skal i brug
void draw() {
  if (!game.getGameState().equals("Game")) return
  if (game.hasGameEnded()) {
    game.setGameState("End");
    game.setupGame(game.getGameState());
    return;
  }
  frames++;
  if (frames >= frameRate / 5) {
    frames = 0;
    // Evt. gøre det her til en metode i Game klasse?
    if (game.getSnake().getNewDirection() != game.getSnake().getDirection()) {
      game.getSnake().setDirection(game.getSnake().getNewDirection());
    }
    
    if (game.hasHitBorder() || game.hasHitSnake()) {
      gameEnded = true;
    }
    
    game.drawMap();
    game.getSnake().update();

    game.addReplay();

    if (hasEatenApple()) {
      snake.getXList().set(snake.getXList().size(), appleX);
      snake.getYList().set(snake.getYList().size(), appleY);
      createAppleCoords();
      score += 1;
    } else {
      fill(210, 0, 0);
      circle(appleX, appleY, FIELD_SIZE / 2);
    }

  }
}
*/


void draw() {  
  if (gameState == "Menu" || gameState == "End" || gameState == "Replay") return;
  if (gameEnded) {
    gameState = "End";
    setupGame(gameState);
    return;
  }
  frames++;
  if (frames >= frameRate / 5){
    if (snake.getNewDirection() != snake.getDirection()) {
      snake.setDirection(snake.getNewDirection());
    }
    frames = 0;
    background(210);
    createLayer();

    switch (snake.getDirection()){
      case "RIGHT":
        snake.getXList().set(0, snake.getXList().get(0) + FIELD_SIZE);
        break;
      case "LEFT":
        snake.getXList().set(0, snake.getXList().get(0) - FIELD_SIZE);
        break;
      case "UP":
        snake.getYList().set(0, snake.getYList().get(0) - FIELD_SIZE);
        break;
      case "DOWN":
        snake.getYList().set(0, snake.getYList().get(0) + FIELD_SIZE);
        break;
      default:
        break;
    }
    snake.drawSnake();

    if (snake.getXList().get(0) < 0 || snake.getXList().get(0) > (FIELDS * FIELD_SIZE) || snake.getYList().get(0) < 0 || snake.getYList().get(0) > (FIELDS * FIELD_SIZE)) {
      gameEnded = true;
    } /*else {
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

    replays.add(new Replay(snake.getXList().copy(), snake.getYList().copy(), appleX, appleY));

    for (int i = snake.getXList().size() - 1; i > 0; i--){
      snake.getXList().set(i, snake.getXList().get(i - 1));
      snake.getYList().set(i, snake.getYList().get(i - 1));
    }
    
    if (hasEatenApple()) {
      snake.getXList().set(snake.getXList().size(), appleX);
      snake.getYList().set(snake.getYList().size(), appleY);
      createAppleCoords();
      score += 1;
    } else {
      fill(210, 0, 0);
      circle(appleX, appleY, FIELD_SIZE / 2);
    }

    fill(127, 0, 127);
    textSize(30);
    text("Score: " + score, width / 2 - FIELD_SIZE, FIELDS * FIELD_SIZE + FIELD_SIZE * 0.75);
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

void keyPressed(){
  //println(keyCode);
  switch (keyCode){
    // evt. lave noget med hvor man kan bruge direction = keyCode / key or something
    // så det er kortere
    case 38: //UP:
      if (snake.getDirection() != "DOWN") {
        snake.setNewDirection("UP");
      }
      break;
    case 40: //DOWN:
      if (snake.getDirection() != "UP") {
        snake.setNewDirection("DOWN");
      }
      break;
    case 39: //RIGHT:
      if (snake.getDirection() != "LEFT") {
        snake.setNewDirection("RIGHT");
      }
      break;
    case 37: //LEFT:
      if (snake.getDirection() != "RIGHT") {
        snake.setNewDirection("LEFT");
      }
      break;
    default:
      break;
  }
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

void mousePressed(){
  if (gameState == "Menu"){
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      gameState = "Game";
      setupGame(gameState);
    }
  } else if (gameState == "End") {
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      gameEnded = false;
      gameState = "Replay";
      setupGame(gameState);
    }
  } else if (gameState == "Replay") {
    //println("index: " + currentReplayIndex);
    if (isInsideRect(20, FIELDS * FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Backwards
      //println("back");
      if (0 > (currentReplayIndex - 1)){
        //println("not set");
        return;
      }
      currentReplayIndex--;
      showReplay(currentReplayIndex);

  } else if (isInsideRect(20 + 80, FIELDS * FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Forward
      //println("forward");
      //println("size: " + replays.size());
      if (replays.size() <= (currentReplayIndex + 1)){
        //println("not set");
        return;
      }
      currentReplayIndex++;
      showReplay(currentReplayIndex);
    }
  }
}

boolean isInsideRect(float rcx, float rcy, float w, float h, float px, float py){
  return isInRange(rcx, rcx + w, px) && isInRange(rcy, rcy + h, py);
}

boolean isInRange(float begin, float end, float value){
  return (begin <= value && value <= end);
}

/*
void drawReplaySnake(Replay r) {
  fill(0, 180, 0);
  for (int i = 0; i < r.getXList().size(); i++){
    circle(r.getXList().get(i), r.getYList().get(i), FIELD_SIZE);
  }
  drawSnakeHead(r.getXList().get(0), r.getYList().get(0));
}
*/

/*
void drawSnake(){
  fill(0, 180, 0);
  for (int i = 0; i < snakeXList.size(); i++){
    circle(snakeXList.get(i), snakeYList.get(i), FIELD_SIZE);
  }
  drawSnakeHead(snakeXList.get(0), snakeYList.get(0));
}
*/

/*
// X og Y skal være midten
void drawSnakeHead(int x, int y){
  fill(0);
  strokeWeight(5);
  point(x - 5, y - 5);
  point(x + 5, y - 5);
  ellipse(x, y + 10, 10, 3);
  strokeWeight(1);
}
*/
