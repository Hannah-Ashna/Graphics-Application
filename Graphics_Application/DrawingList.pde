class DrawingList {
  ArrayList<Shape> shapesList = new ArrayList<Shape>();
  
  public Shape currentlyDrawnShape = null;
  
  public DrawingList() {}
  
  public void drawShapes() {
    for (Shape s : shapesList){
      s.drawShapes();
    }
  }
  
  public void mouseDrawEvent (String shapeType, String event, PVector mouseLoc){
    if (event.equals("mousePressed")) {
      println("eeeee");
      Shape newShape = new Shape(shapeType);
      newShape.startDrawing(mouseLoc);
      shapesList.add(newShape);
      currentlyDrawnShape = newShape;
    }

    if (event.equals("mouseDragged")) {
      currentlyDrawnShape.duringDrawing(mouseLoc);
    }

    if (event.equals("mousePressed")) {
      currentlyDrawnShape.endDrawing(mouseLoc);
    }
  }
 
}
