// TODO:
//  - int[][] grid, med 0 = intet, 1 = snake, 2 = apple, (evt. 3 = snakeHead?)
//    I stedet for at bruge IntList xList, yList - Vil gøre det bedre i guess, også ift. at tjekke når man dør ved at gå ind i sig selv

// KENDTE FEJL
//  - Man kan gå ind i Snaken og dør ikke, nu kan man hvis score < 7

int frames = 0;
int highscore = 0;

ArrayList<Game> previousGames = new ArrayList<Game>();
Game game;

void setup(){
  size(600, 640);
  game = new Game(highscore);
  frameRate(120);
}

void draw() {
  if (!game.getGameState().equals(GameState.GAME) && !game.getGameState().equals(GameState.REPLAY)) return;
  frames++;
  if (game.getGameState().equals(GameState.REPLAY)) {
    // Check and do Auto replay
    if (frames >= frameRate / 5) {
      frames = 0;
      if (game.isAutoReplay()) {
        game.showReplay("forward"); // Lave noget om det ska være back / forward
      }
    }
    return;
  }

  if (game.hasGameEnded()) {
    checkAndSetHighscore(game.getScore());
    game.setGameState(GameState.END);
    game.setupGame(game.getGameState());
    return;
  }
  if (frames >= frameRate / 8) {
    frames = 0;
    game.checkAndUpdateDirection();

    if (game.hasHitBorder() || game.hasHitSnake()) {
      game.setEnded(true);
    }
    
    game.getSnake().updateSelf();
    game.drawMap();
    game.addReplay();
    game.getSnake().update();
  }
}

// Key Pressed event to get new direction
void keyPressed(){
  switch (keyCode){
    case 38: // UP
      if (game.getSnake().getDirection() != Direction.DOWN) {
        game.getSnake().setNewDirection(Direction.UP);
      }
      break;
    case 40: // DOWN
      if (game.getSnake().getDirection() != Direction.UP) {
        game.getSnake().setNewDirection(Direction.DOWN);
      }
      break;
    case 39: // RIGHT
      if (game.getSnake().getDirection() != Direction.LEFT) {
        game.getSnake().setNewDirection(Direction.RIGHT);
      }
      break;
    case 37: // LEFT
      if (game.getSnake().getDirection() != Direction.RIGHT) {
        game.getSnake().setNewDirection(Direction.LEFT);
      }
      break;
    default:
      break;
  }
}

// Mouse pressed event to check if it's inside a square
void mousePressed(){
  if (game.getGameState().equals(GameState.MENU)) {
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      game.setGameState(GameState.GAME);
      game.setupGame(game.getGameState());
    }
  } else if (game.getGameState().equals(GameState.END)) {
    if (isInsideRect(100, 100, width - 200, height - 300, mouseX, mouseY)) {
      // Blå - Replay system
      game.setGameState(GameState.REPLAY);
      game.setupGame(game.getGameState());
      previousGames.add(game);
    } else if (isInsideRect(100, height - 150, width - 200, 100, mouseX, mouseY)) {
      // Orange - New game
      game = new Game(highscore);
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
      game.setAutoReplay(!game.isAutoReplay());
    } else if (isInsideRect(20 + 480, game.FIELDS * game.FIELD_SIZE + 3, 60, 34, mouseX, mouseY)) {
      // Orange - Back to End screen
      game.setGameState(GameState.END);
      game.setupGame(game.getGameState());
    }
  }
}

void checkAndSetHighscore(int score) {
  if (getHighscore() < score) {
    setHighscore(score);
  }
}

void setHighscore(int score) {
  this.highscore = score;
}

int getHighscore() {
  return highscore;
}

boolean isInsideRect(float rcx, float rcy, float w, float h, float px, float py) {
  return isInRange(rcx, rcx + w, px) && isInRange(rcy, rcy + h, py);
}

boolean isInRange(float begin, float end, float value) {
  return (begin <= value && value <= end);
}
