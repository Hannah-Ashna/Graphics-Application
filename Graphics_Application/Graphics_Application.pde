// ===================================
//       Main File - Graphics App
// ------------------------------------
// By: Hannah Ashna Jacob (2020 - 2021)
// For: NTU Maths & Graphics Module
// ====================================

import g4p_controls.*;
import processing.event.MouseEvent;

DrawingList drawingList;

String toolMode = "";
String imageStyle = "";
String mouseEventType = "mousePressed";
boolean newImage = false;

void setup(){
  size(900, 800);
  
  // Setup the GUI
  GUI();
  
  // Setup Drawing List
  drawingList = new DrawingList();

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
  
  // Check if there is any new image to be loaded
  if (newImage == true && outputImage != null) {
    drawingList.setImage(outputImage);
  }
  
  // Check for any drawing events
  handleEvent();
  drawingList.drawShapes();
  
  // Prevent overflow
  noStroke();
  fill(134, 136, 138);
  rect(0,0, 280, 800);
  rect(280, 0, 620, 80);
  rect(280, 681, 620, 120);
  rect(881, 0, 20, 800);
  
  // Colour Viewer for RGB Knobs - Stroke
  strokeWeight(1);
  stroke(0, 0, 0);
  fill(r, g, b);
  square(50, 600, 40);
  
  // Colour Viewer for RGB Knobs - Fill
  strokeWeight(1);
  stroke(0, 0, 0);
  fill(r2, g2, b2);
  square(180, 600, 40);
}

// ---------- Other Functions (Drawing) ----------------

// Monitors button and mouse events for Drawing
void handleEvent(){
  if ((toolMode.equals("rect") || toolMode.equals("ellipse") || toolMode.equals("line") || toolMode.equals("curve") || toolMode.equals("poly")) && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    int mouseEventType = mouseEvent.getAction(); //mouseEvent is deprecated eventually need to seek an alternative
    PVector point = new PVector(mouseX, mouseY);
    drawingList.mouseDrawEvent(toolMode, mouseEventType, point);
    return;
  }
  
  // Reset the drawing list/canvas
  if(toolMode.equals("reset")){
    drawingList.reset();
  }
  
  // Delete a shape object
  if(toolMode.equals("delete")){
    drawingList.deleteObject();
  }
  
  // Move a shape object
  if(toolMode.equals("move") && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    PVector point = new PVector(mouseX, mouseY);
    int mouseEventType = mouseEvent.getAction();
    drawingList.moveObject(point, mouseEventType);
  }
  
  // Resize a shape object
  if(toolMode.equals("resize") && (mouseX > 280 && mouseX < 880) && (mouseY > 80 && mouseY <680)){
    PVector point = new PVector(mouseX, mouseY);
    int mouseEventType = mouseEvent.getAction();
    drawingList.resizeObject(point, mouseEventType);
  }
  
  // Modify image filter/effect
  if( (imageStyle.equals("None") || imageStyle.equals("HSV") || imageStyle.equals("Negative") || imageStyle.equals("Greyscale") || imageStyle.equals("Blur") 
  ||imageStyle.equals("Sharpen") || imageStyle.equals("Edge") || imageStyle.equals("Brightness") || imageStyle.equals("Contrast"))){
    drawingList.applyEffect(imageStyle);
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
