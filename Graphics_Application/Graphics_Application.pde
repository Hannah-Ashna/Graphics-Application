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
  //drawingList.initCanvas();
  
  // Custom Cursor
  cursor(CROSS);
}

void draw() {
  // Set application background colour
  background(134, 136, 138);
  
  // Setup Canvas
  strokeWeight(2);
  stroke(0, 0, 0);
  fill(255, 255, 255);
  square(280, 80, 600);
  
  // Check if there is any image to be loaded
  if (outputImage != null) {
    image(outputImage, 290, 90);
  }
  
  // Check for any drawing events
  handleEvent();
  drawingList.drawShapes();
}

// ---------- Other Functions ----------------

// Monitors button and mouse events for Drawing
void handleEvent(){
  if ((toolMode.equals("rect") || toolMode.equals("ellipse") || toolMode.equals("line") || toolMode.equals("curve")) && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    int mouseEventType = mouseEvent.getAction(); //mouseEvent is deprecated eventually need to seek an alternative
    PVector point = new PVector(mouseX, mouseY);
    drawingList.mouseDrawEvent(toolMode, mouseEventType, point);
    return;
  }
  
  if(toolMode.equals("reset")){
    drawingList.reset();
  }
  
  if(toolMode.equals("delete")){
    drawingList.deleteObject();
  }
  
  if(toolMode.equals("resize") && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    PVector point = new PVector(mouseX, mouseY);
    int mouseEventType = mouseEvent.getAction();
    drawingList.resizeObject(point, mouseEventType);
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
