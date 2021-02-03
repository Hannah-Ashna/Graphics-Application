class DrawingList {
  ArrayList<Shape> shapesList = new ArrayList<Shape>();
  
  public Shape currentlyDrawnShape = null;
  
  public DrawingList() {}
  
  public void drawShapes() {
    for (Shape s : shapesList){
      s.drawShapes();
    }
  }
  
  public void mouseDrawEvent (String shapeType, int event, PVector mouseLoc){
    
    if (event == 1) {
      println("Mouse Pressed");
      Shape newShape = new Shape(shapeType);
      newShape.startDrawing(mouseLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
    }

    if (event == 4) {
      println("Mouse Dragged");
      currentlyDrawnShape.duringDrawing(mouseLoc);
    }

    if (event == 2) {
      println("Mouse Released");
      currentlyDrawnShape.endDrawing(mouseLoc);
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
 
}
