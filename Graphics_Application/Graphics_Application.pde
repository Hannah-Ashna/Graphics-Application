import g4p_controls.*;
import processing.event.MouseEvent;

DrawingList drawingList;
String toolMode = "";
String mouseEventType = "mousePressed";

void setup(){
  size(900, 800);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
  
  // Setup Drawing List
  drawingList = new DrawingList();
  drawingList.initCanvas();
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
