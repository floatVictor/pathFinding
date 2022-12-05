class Brain {
  PVector[] directions;
  int step = 0;
  
  Brain(int size) {
    directions = new PVector[size];
    init();
  }
  
  void init() {
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }
  
  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }
  
  void mutate() {
    float chance = mutationChance;
    for (int i =0; i< directions.length; i++) {
      float r = random(1);
      if (r < chance) {
        float angle = random(2*PI);
        directions[i] = PVector.fromAngle(angle);
      }
    }
  }
}
