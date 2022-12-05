class Population {
  Particule[] particules;
  int gen = 1;
  
  float totalFitness;
  int minStep = 1000;
  int bestIndex = 0;
  
  int nbAlive;
  
  Population(int size, PVector start, PVector target, int id) {
    particules = new Particule[size];
    for (int i = 0; i < size; i++) {
      particules[i] = new Particule(start, target, id);
    }
    nbAlive = size;
  }
  
  //--------------------------------------------------------------------
  
  void display() {
    for (int i = 1; i< particules.length; i++) {
      particules[i].display();
    }
    particules[0].display();
  }
  
  void update() {
    for (int i = 0; i< particules.length; i++) {
      if (particules[i].b.step > minStep) {
        particules[i].alive = false;
      } 
      else {
        particules[i].update();
      }
    }
  }
  
  //--------------------------------------------------------------------
  
  void setFitness() {
    for (int i = 0; i< particules.length; i++) {
      particules[i].setFitness();
    }
  }
  
  boolean allDead() {
    for (int i = 0; i< particules.length; i++) {
      if(particules[i].alive && !particules[i].win) return false;
    }
    return true;
  }
  
  void selection() {
    Particule[] newParticules = new Particule[particules.length];
    setBest();
    calculateTotalFitness();
    newParticules[0] = particules[bestIndex].getBaby();
    newParticules[0].isBest = true;
    
    for (int i = 1; i < newParticules.length; i++) {
      Particule p = selectParent();
      newParticules[i] = p.getBaby();
    }
    particules = newParticules;
    gen++;
  }
  
  void calculateTotalFitness() {
    totalFitness = 0;
    for (int i = 0; i< particules.length; i++) {
      totalFitness += particules[i].fitness;
    }
  }
  
  Particule selectParent() {
    float val = random(totalFitness);
    float currVal = 0;

    for (int i = 0; i< particules.length; i++) {
      currVal += particules[i].fitness;
      if (currVal > val) {
        return particules[i];
      }
    }
    
    return null;
  }
  
  void mutation() {
    for (int i = 1; i< particules.length; i++) {
      particules[i].b.mutate();
    }
  }
  
  void setBest() {
    float maxFitness = 0;
    int maxIndex = 0;
    for (int i = 0; i< particules.length; i++) {
      if(particules[i].fitness > maxFitness) {
        maxFitness = particules[i].fitness;
        maxIndex = i;
      }
    }
    bestIndex = maxIndex;
    
    if(particules[bestIndex].win) {
      minStep = particules[bestIndex].b.step;
      println("team : ",particules[bestIndex].id,"   gen : ", gen,"   minStep : ",minStep);
    }
  }
}
