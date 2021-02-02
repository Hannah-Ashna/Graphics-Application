import g4p_controls.*;

PVector pointA = new PVector(280,80);
PVector pointB = new PVector(280,80);

boolean check = false;

void setup(){
  size(900, 800);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
}

void draw() {
  background(134, 136, 138);
  square(280, 80, 600);
  if (outputImage != null) {
    image(outputImage, 290, 90);
  }
  
  if (check == true){
    rectangle();  
  }
  
}

void mousePressed(){
  if((mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    pointA.x = mouseX;
    pointA.y = mouseY;
    check = false;
  }
}

void mouseReleased(){
  if((mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    pointB.x = mouseX;
    pointB.y = mouseY;
    check = true;
  }
}

void rectangle(){
  float w = pointB.x - pointA.x;
  float h = pointB.y - pointA.y;
  
  rect(pointA.x, pointA.y, w, h);
}
