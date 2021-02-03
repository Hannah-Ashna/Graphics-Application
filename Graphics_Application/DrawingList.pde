class DrawingList {
  ArrayList<Shape> shapesList = new ArrayList<Shape>();
  
  public Shape currentlyDrawnShape = null;
  
  public DrawingList() {}
  
  public void drawShapes() {
    for (Shape s : shapesList){
      s.drawShapes();
    }
  }

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
  
  public void mouseDrawEvent (String shapeType, int eventType, PVector mouseLoc){
    
    if (eventType == 1) {
      println("Mouse Pressed");
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
      currentlyDrawnShape.endDrawing(mouseLoc);
    }
  }
  
  public void selectObject(int eventType, PVector mouseLoc) {
    if (eventType == 1) {
      for (Shape s : shapesList) {
        println("Selection in progress!");
        println(mouseLoc);
        boolean selectionMade = s.toggleSelect(mouseLoc);
        if (selectionMade) break;
      }
    }
  } 
  
  public void deleteObject() {
    ArrayList<Shape> tempShapeList = new ArrayList<Shape>();
    for (Shape s : shapesList) {
      if (s.isSelected == false) tempShapeList.add(s);
    }
    
    shapesList = tempShapeList;
  }

 
}
