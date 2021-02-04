class DrawingList {
  ArrayList<Shape> shapesList = new ArrayList<Shape>();
  
  public Shape currentlyDrawnShape = null;
  
  public DrawingList() {}
  
  public void drawShapes() {
    for (Shape s : shapesList){
      s.drawShapes();
    }
  }
  
  // Function no longer used
  // Being part of the drawing list meant that it would cover any image that was loaded (Can be used if image editing is not used)
  public void initCanvas() {
      println("Initialising Canvas");
      PVector canvasLoc = new PVector(280, 80);
      Shape newShape = new Shape("initial");
      newShape.startDrawing(canvasLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
      canvasLoc.set(880, 680);
      currentlyDrawnShape.endDrawing(canvasLoc);
  }  
  
  // Capture mouse events to decide what shape to draw
  public void mouseDrawEvent (String shapeType, int eventType, PVector mouseLoc){
    
    if (eventType == 1) {
      println("Mouse Pressed");
      //beginShape();
      Shape newShape = new Shape(shapeType);
      newShape.startDrawing(mouseLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
      
    }
    
    if (eventType == 4) {
      println("Mouse Dragged");
      currentlyDrawnShape.duringDrawing(mouseLoc);
    }

    if (eventType == 2) {
      println("Mouse Released");
      if (shapeType == "curve"){
         currentlyDrawnShape.drawCurve();
      }
      currentlyDrawnShape.endDrawing(mouseLoc);      
    }
  }
  
  // Select an existing shape object
  public void selectObject(int eventType, PVector mouseLoc) {
    if (eventType == 1) {
      for (Shape s : shapesList) {
        boolean selectionMade = s.toggleSelect(mouseLoc);
        if (selectionMade) break;
      }
    }
  } 
  
  // Delete an existing shape object
  public void deleteObject() {
    ArrayList<Shape> tempShapeList = new ArrayList<Shape>();
    for (Shape s : shapesList) {
      if (s.isSelected == false) tempShapeList.add(s);
    }
    
    shapesList = tempShapeList;
  }
  
  // Reset canvas
  public void reset(){
    ArrayList<Shape> tempShapeList = new ArrayList<Shape>();
    shapesList = tempShapeList;
  }

}
