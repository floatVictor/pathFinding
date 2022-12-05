import controlP5.*;

ControlP5 cp5;
PGraphics pg;

Population pop;
Population pop2;
Obstacles obs;
PVector firstStart;
PVector secondStart; 

//global
int opacity = 20;
int size = 1;
float maxVel = 5;

//distortion
float distortion = 0;
float noiseDistortion = 0;
float noiseRatio = 0.5;
float noiseSpeed = 0.5;

int brainSize = 1000;
int popSize = 1000;
float mutationChance = 0.1;

//obstacles
int nbObs = 55;
PVector obsXRange;
PVector obsYRange;
int sizeRangeX = 110;
int sizeRangeY = 110;


//UI
boolean visible = true;
int sliderLength = 200;
boolean showBack = false;

//color
int h = (int)random(255);
int offSat = 10;

void setup() {
  size(1600, 1000);
  frameRate(100000);
  background(10);
  
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.colorMode(HSB);
  pg.background(10);
  pg.endDraw();
  
  obsXRange = new PVector(0, width);
  obsYRange = new PVector(120, height - 120 - sizeRangeY);
  
  firstStart = new PVector(random(200, width - 200), height - 80);
  secondStart = new PVector(random(200, width - 200), 80);
  pop = new Population(popSize, firstStart, secondStart, 0);
  pop2 = new Population(popSize, secondStart, firstStart, 1);
  obs = new Obstacles();
  
  
  setUi();
  println("generation : ", 1);
}

void draw(){
  
  pg.beginDraw();
  if (showBack) pg.background(10);
  
  if (pop.allDead() && pop2.allDead()) { 
    pop.setFitness();
    pop.selection();
    pop.mutation();
    pop2.setFitness();
    pop2.selection();
    pop2.mutation();
    println("generation : ", pop.gen);
    
  }
  pop.update();
  pop.display();
  pop2.update();
  pop2.display();
  pg.endDraw();
  image(pg, 0, 0);
  if(!visible) cp5.hide();
  else  cp5.show();
  cp5.draw();
}

void keyPressed() {
  if (key == 'r') {
    firstStart = new PVector(random(200, width - 200), height - 80);
    secondStart = new PVector(random(200, width - 200), 80);
    pop = new Population(popSize, firstStart, secondStart, 0);
    pop2 = new Population(popSize, secondStart, firstStart, 1);
    obs = new Obstacles();
    pg.background(10);
  }
  if (key == 'o') {
    obs = new Obstacles();
    obs.display();
  }
  if (key == 'b') showBack = !showBack;
  if (key == 'h') visible = !visible;
  if (key == 's') saveFrame("saveFrame/gen-#####.png");
}
