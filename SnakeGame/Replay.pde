class Replay {
  private IntList xList, yList;
  private int appleX, appleY;
  
  public Replay(IntList xList, IntList yList, int appleX, int appleY) {
    this.xList = xList;
    this.yList = yList;
    this.appleX = appleX;
    this.appleY = appleY;
  }
  
  IntList getXList(){
    return xList;
  }

  IntList getYList(){
    return yList;
  }
  
  int getAppleX() {
    return appleX;
  }

  int getAppleY() {
    return appleY;
  }
}
