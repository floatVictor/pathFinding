class Obstacles {
  
  PVector[][] pattern;
  
  Obstacles() {
    pattern = new PVector[nbObs][4];
    for (int i = 0; i < nbObs; i ++) {
      PVector start = new PVector(random(obsXRange.x, obsXRange.y), random(obsYRange.x, obsYRange.y));
      pattern[i][0] = start;
      pattern[i][1] = new PVector(start.x + random(sizeRangeX), start.y);
      pattern[i][2] = new PVector(start.x, start.y + random(sizeRangeY));
      pattern[i][3] = new PVector(start.x + random(sizeRangeX), start.y + random(sizeRangeY));
      //println(pattern[i][0].x, pattern[i][1].x);
    }
  }
  
  void display() {
    for (int i = 0; i < nbObs; i ++) {
      pg.noStroke();
      pg.fill(150, 120, 25);
      pg.rect(pattern[i][0].x, pattern[i][0].y, pattern[i][1].x - pattern[i][0].x, pattern[i][3].y - pattern[i][0].y);
    }
  }
}
