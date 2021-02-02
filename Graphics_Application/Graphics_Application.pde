import g4p_controls.*;
import java.awt.event.*;

DrawingList drawingList;
String toolMode = "";
String mouseEventType = "mousePressed";
PVector point;
void setup(){
  size(900, 800);
  
  // Custom Cursor
  cursor(CROSS);
  
  // Setup the GUI
  GUI();
  
  // Setup Drawing List
  drawingList = new DrawingList();
}

void draw() {
  background(134, 136, 138);
  //square(280, 80, 600);
  if (outputImage != null) {
    image(outputImage, 290, 90);
  }
  handleEvent();
  drawingList.drawShapes();
}


void handleEvent() {
  
  
  if ((toolMode.equals("rect") || toolMode.equals("ellipse") || toolMode.equals("line")) && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    drawingList.mouseDrawEvent(toolMode, mouseEventType, point);
    return;
  }
}

void mousePressed(){
  mouseEventType = "mousePressed";
  point(mouseX, mouseY);
}

void mouseDragged(){
  mouseEventType = "mouseDragged";
  point(mouseX, mouseY);
  
}

void mouseReleased(){
  mouseEventType = "mouseReleased";
  point(mouseX, mouseY);
}
