// TODO:
//  - I replay system, tilføje så man kan gøre så det automatisk kører frem/tilbage ved X frames
//  - Idk om jeg laver Direction ENUM eller om jeg bruger 'key' i mousePressed, har gjort klar til ENUM'et
//    eller bruge HashMap<int(key), String> som parser en key til RIGHT, LEFT, UP el. DOWN
//  - GameState ENUM? GameState.MENU, GAME, END, REPLAY? har lavet den i hvert fald
//  - Lave et restart system
//  - Multiplayer?
//  - Apple class

// KENDTE FEJL
//  - I replay kan man gå så langt som man vil, stopper ikke når snaken var død (skal lige debugges) - Den går 1 længere
//  - Man kan gå ind i Snaken og dør ikke

int frames = 0;

ArrayList<Game> previousGames = new ArrayList<Game>();
Game game;

void setup(){
  size(600, 640);
  game = new Game();
  frameRate(120);
}

void draw() {
  if (!game.getGameState().equals(GameState.GAME)) return;
  if (game.hasGameEnded()) {
    game.setGameState(GameState.END);
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
      game.gameEnded = true;
    }
    
    game.getSnake().updateSelf();
    game.drawMap();
    game.addReplay();
    game.getSnake().update();
  }
}

void keyPressed(){
  //println(keyCode);
  switch (keyCode){
    // evt. lave noget med hvor man kan bruge direction = keyCode / key or something
    // så det er kortere
    case 38: //UP:
      if (game.getSnake().getDirection() != Direction.DOWN) {
        game.getSnake().setNewDirection(Direction.UP);
      }
      break;
    case 40: //DOWN:
      if (game.getSnake().getDirection() != Direction.UP) {
        game.getSnake().setNewDirection(Direction.DOWN);
      }
      break;
    case 39: //RIGHT:
      if (game.getSnake().getDirection() != Direction.LEFT) {
        game.getSnake().setNewDirection(Direction.RIGHT);
      }
      break;
    case 37: //LEFT:
      if (game.getSnake().getDirection() != Direction.RIGHT) {
        game.getSnake().setNewDirection(Direction.LEFT);
      }
      break;
    default:
      break;

    
    /*
    case 38: //UP:
      if (game.getSnake().getDirection() != "DOWN") {
        game.getSnake().setNewDirection("UP");
      }
      break;
    case 40: //DOWN:
      if (game.getSnake().getDirection() != "UP") {
        game.getSnake().setNewDirection("DOWN");
      }
      break;
    case 39: //RIGHT:
      if (game.getSnake().getDirection() != "LEFT") {
        game.getSnake().setNewDirection("RIGHT");
      }
      break;
    case 37: //LEFT:
      if (game.getSnake().getDirection() != "RIGHT") {
        game.getSnake().setNewDirection("LEFT");
      }
      break;
    default:
      break;
    */
  }
}


void mousePressed(){
  if (game.getGameState().equals(GameState.MENU)) {
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      game.setGameState(GameState.GAME);
      game.setupGame(game.getGameState());
    }
  } else if (game.getGameState().equals(GameState.END)) {
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      game.gameEnded = false; // ændre det her til metode
      game.setGameState(GameState.REPLAY);
      game.setupGame(game.getGameState());
      previousGames.add(game);
    }
  } else if (game.getGameState().equals(GameState.REPLAY)) {
    println("index: " + game.currentReplayIndex);
    if (isInsideRect(20, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Backwards
      println("back");
      if (0 > (game.currentReplayIndex - 1)){
        println("not set");
        return;
      }
      game.currentReplayIndex--;
      game.showReplay(game.currentReplayIndex);

    } else if (isInsideRect(20 + 80, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Forward
      println("forward");
      println("size: " + game.getReplays().size());
      if (game.getReplays().size() <= (game.currentReplayIndex + 1)){
        println("not set");
        return;
      }
      game.currentReplayIndex++;
      game.showReplay(game.currentReplayIndex);
    }
  }
}

boolean isInsideRect(float rcx, float rcy, float w, float h, float px, float py){
  return isInRange(rcx, rcx + w, px) && isInRange(rcy, rcy + h, py);
}

boolean isInRange(float begin, float end, float value){
  return (begin <= value && value <= end);
}
