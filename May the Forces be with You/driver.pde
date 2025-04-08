int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;


int BOUNCE = 0;
int GRAVITY = 1;
int DRAGF = 3;
int SPRING = 2;
int ATTRACT = 4;
int COMBO = 5;
boolean[] toggles = new boolean[6];
boolean[] sims = new boolean[6];
String[] modes = {"Bounce", "Gravity", "Spring", "Drag", "Attraction", "Combo"};
String[] simss = {"Gravity", "Spring Force", "Drag", "Attractiveness", "Combo"};

FixedOrb earth;

OrbList sim;

void setup() {
  size(600, 600);

  earth = new FixedOrb(width/2, height/2, 20, 100);
  sim = new OrbList();
  sim.populate(NUM_ORBS, true);
  
  toggles[BOUNCE] = true;
}//setup

void draw() {
  background(255);
  displayMode();

  sim.display();
  earth.display();
  if (toggles[GRAVITY]) {
    sim.applyGravity(earth, G_CONSTANT);
  }
  sim.run(toggles[BOUNCE]);
  if (toggles[SPRING]) {
    sim.applySprings(SPRING_LENGTH, SPRING_K);
  }
  if (toggles[DRAGF]) {
    noFill();
    stroke(0, 0, 0);
    rect(0, height/2, width, height/2, 0);

    for (int i = 0; i < NUM_ORBS; i++) {
      if (sim.list[i].center.y > height/2) {
        PVector drag = sim.list[i].getDragForce(D_COEF);
        sim.list[i].applyForce(drag);
      }
    }
  }
  if(toggles[ATTRACT]){
    for(int i = 0; i<NUM_ORBS-1; i++){
      if(i>0){
        sim.applyAttraction(sim.list[i+1], G_CONSTANT);
      }
    }
  }
  
}//mousePressed

void keyPressed() {
  if (key == '1') {
    SimulationOne();
  }
  if (key == '2') {
    SimulationTwo();
  }
  if (key == '3') {
    SimulationThree();
  }
  if(key=='4'){
    SimulationFour();
  }
  if(key == '5'){
    SimulationFive();
  }
}//keyPressed

void SimulationOne() {
  toggles[GRAVITY] = !toggles[GRAVITY];
  toggles[SPRING] = false;
  toggles[DRAGF] = false;
  toggles[ATTRACT] = false;
  toggles[COMBO] = false;
}

void SimulationTwo() {
  toggles[SPRING] = !toggles[SPRING];
  toggles[DRAGF] = false;
  toggles[GRAVITY] = false;
  toggles[ATTRACT] = false;
  toggles[COMBO] = false;
}

void SimulationThree() {
  toggles[DRAGF] = !toggles[DRAGF];
  toggles[GRAVITY] = false;
  toggles[SPRING] = false;
  toggles[ATTRACT] = false;
   toggles[COMBO] = false;
}

void SimulationFour(){
  toggles[ATTRACT] = !toggles[ATTRACT];
  toggles[GRAVITY] = false;
  toggles[SPRING] = false;
  toggles[DRAGF] = false;
  toggles[COMBO] = false;

}

void SimulationFive(){
  toggles[DRAGF] = false;
  toggles[GRAVITY] = false;
  toggles[ATTRACT] = false;
  toggles[SPRING] = false;
  toggles[COMBO] = false;
  toggles[ATTRACT] = !toggles[ATTRACT];
  toggles[GRAVITY] = !toggles[GRAVITY];
  toggles[SPRING] = !toggles[SPRING];
  toggles[DRAGF] = !toggles[DRAGF];
  toggles[COMBO] = !toggles[COMBO];

}

void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;
  int y = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
  
  for(int i = 0; i<sims.length; i++){
    if(sims[i]){
      fill(0,255,0);
    }
    else{
      fill(255,0,0);
    }
  }
    

}//display
