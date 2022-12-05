class Particule {
  PVector pos;
  PVector vel;
  PVector acc;
  
  Brain b;
  boolean alive = true;
  boolean win = false;
  boolean isBest = false;
  
  float fitness = 0;
  float prevFitness;
  
  PVector start;
  PVector target;
  int id;
  
  boolean border = false;
  
  Particule(PVector _start, PVector _target,int _id) {
    b = new Brain(brainSize);
    target = _target;
    start = _start;
    id = _id;
    //pos = new PVector(random(width/2 - 100, width/2 + 100), height - 100);
    pos = new PVector(start.x, start.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  //--------------------------------------------------------------------
  
  void display() {
    pg.noStroke();
    /*if(isBest) {
      if(id == 0) fill(150, 255, 255, opacity * 3);
      else fill(210, 255, 255, opacity * 3);
      ellipse(pos.x, pos.y, size*3, size*3);
    }
    else {
      if(id == 0) fill(150, map(mag(vel.x, vel.y), 0, maxVel, 0, 160),150 + ((prevFitness + 5) * 15), opacity);
      else fill(210, map(mag(vel.x, vel.y), 0, maxVel, 0, 160),150 + ((prevFitness + 5) * 15), opacity);
      ellipse(pos.x, pos.y, size, size);
    }*/
    if(!border && !win) {
      float noiseX = map(noise(pos.x * 0.01 * noiseRatio, frameCount * 0.01 * noiseSpeed), 0, 1, -noiseDistortion, noiseDistortion);
      float noiseY = map(noise(pos.y * 0.01 * noiseRatio, frameCount * 0.01 * noiseSpeed), 0, 1, -noiseDistortion, noiseDistortion);
      if(id == 0) 
        pg.fill(h, map(mag(vel.x, vel.y), 0, maxVel, 255, 0) + offSat,150 + ((prevFitness + 5) * 15), opacity);
      else pg.fill((h + 30)%255, map(mag(vel.x, vel.y), 0, maxVel, 255, 0) + offSat,150 + ((prevFitness + 5) * 15), opacity);
      pg.ellipse(pos.x + noiseX + random(-distortion, distortion), pos.y + noiseY + random(-distortion, distortion), size, size);
    }
  }
  
  void move(){
    
    if (b.step < brainSize) {
      acc = b.directions[b.step];
      b.step++;
    }
    
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
  }
  
  void update() {
    if (alive && !win) {
      move();
      if (pos.x < - 2|| pos.y < - 2 || pos.x > width + 2 || pos.y > height + 2) {
        alive = false;
        if(id == 0) pop.nbAlive --;
        else pop2.nbAlive --;
        border = true;
      }
      else if (dist(pos.x, pos.y, target.x, target.y) < 10) {
        alive = false;
        if(id == 0) pop.nbAlive --;
        else pop2.nbAlive --;
        win = true;
      }
      else {
        for(int i = 0; i < nbObs; i++) {
            if (pos.x > obs.pattern[i][0].x && pos.x < obs.pattern[i][1].x && pos.y > obs.pattern[i][0].y && pos.y < obs.pattern[i][3].y) {
              alive = false;
              //println(obs.pattern[i][0].x, obs.pattern[i][1].x);
            }
        }
      }
    }
  }
  
  //--------------------------------------------------------------------
  
  void setFitness() {
    if (win) {
      fitness = 1.0/16.0 + 10000.0/(float)(b.step * b.step);
    }
    else {
      float dist = dist(pos.x, pos.y, target.x, target.y);
      fitness = 1. / (dist*dist);
    }
  }
  
  Particule getBaby() {
    Particule baby = new Particule(start, target, id);
    baby.b = b.clone();
    baby.prevFitness = fitness * pow(10, 6);
    return baby;
  }
  
}
