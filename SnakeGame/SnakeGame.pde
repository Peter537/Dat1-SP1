// TODO:
//  - Lave et restart system
//  - Multiplayer?
//  - Mere tekst på skærmen ex: Replay system, om man er død eller ej

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
  if (!game.getGameState().equals(GameState.GAME) && !game.getGameState().equals(GameState.REPLAY)) return;
  frames++;
  if (game.getGameState().equals(GameState.REPLAY)) {
    if (frames >= frameRate / 5) {
      frames = 0;
      if (game.isAutoReplay()) {
        game.showReplay("forward"); // Lave noget om det ska være back / forward
      }
    }
    return;
  }
  
  if (game.hasGameEnded()) {
    game.setGameState(GameState.END);
    game.setupGame(game.getGameState());
    return;
  }
  if (frames >= frameRate / 5) {
    frames = 0;
    game.checkAndUpdateDirection();

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
    if (isInsideRect(20, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Rød - Back
      game.showReplay("back");
    } else if (isInsideRect(20 + 80, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Green - Forward
      game.showReplay("forward");
    } else if (isInsideRect(20 + 160, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Blå - Fremad Auto
      game.isAutoReplay = !game.isAutoReplay; // lave til metode
    }
  }
}

boolean isInsideRect(float rcx, float rcy, float w, float h, float px, float py){
  return isInRange(rcx, rcx + w, px) && isInRange(rcy, rcy + h, py);
}

boolean isInRange(float begin, float end, float value){
  return (begin <= value && value <= end);
}
