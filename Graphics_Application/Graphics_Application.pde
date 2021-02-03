import g4p_controls.*;
import processing.event.MouseEvent;

DrawingList drawingList;
String toolMode = "";
String mouseEventType = "mousePressed";

void setup(){
  size(900, 800);
  
  // Setup the GUI
  GUI();
  
  // Setup Drawing List
  drawingList = new DrawingList();
  drawingList.initCanvas();
  
  // Custom Cursor
  cursor(CROSS);
}

void draw() {
  background(134, 136, 138);
  
  if (outputImage != null) {
    image(outputImage, 290, 90);
  }
  
  handleEvent();
  drawingList.drawShapes();
}


void handleEvent(){
  if ((toolMode.equals("rect") || toolMode.equals("ellipse") || toolMode.equals("line")) && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    int mouseEventType = mouseEvent.getAction();
    PVector point = new PVector(mouseX, mouseY);
    drawingList.mouseDrawEvent(toolMode, mouseEventType, point);
    return;
  }
}

// For Selecting an Object
void mousePressed(){
    if (toolMode.equals("select")){
    int mouseEventType = mouseEvent.getAction();
    PVector point = new PVector(mouseX, mouseY);
    drawingList.selectObject(mouseEventType, point);
  }
}

// For Deleting an Object
void keyPressed(){
  if(key == BACKSPACE){
    drawingList.deleteObject();
  }
}
