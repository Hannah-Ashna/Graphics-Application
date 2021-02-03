class Shape {
  
  String drawingMode = "";
  PVector pointA;
  PVector pointB;
  
  boolean isSelected = false;
  boolean isBeingDrawn = false;
  
  // Initialise drawn object
  public Shape (String drawingMode){
    this.drawingMode = drawingMode;
  }
  
  // Start the drawing of shape object
  public void startDrawing(PVector start) {
     this.isBeingDrawn = true;
     this.pointA = start;
     this.pointB = start;
     print(pointA);
     print(pointB);
  }
  
  // During the drawing of shape object
  public void duringDrawing(PVector dragPoint) {
    if(this.isBeingDrawn) {
      this.pointB = dragPoint;
    }
  }
  
  // End the drawing of shape object
  public void endDrawing(PVector end){
     this.pointB = end;
     this.isBeingDrawn = false;
  }
  
  public void drawShapes() {
    float x1 = this.pointA.x;
    float y1 = this.pointA.y;
    float x2 = this.pointB.x;
    float y2 = this.pointB.y;
    float w = x2-x1;
    float h = y2-y1;
    
    if (this.isSelected) {
      setSelectedDrawingStyle();
    } else{
      setDefaultDrawingStyle(); 
    }
    
    if ( drawingMode == "rect") {
      rect(x1, y1, w, h);
    }
    
    if ( drawingMode == "ellipse") {
      ellipse(x1+ w/2, y1 + h/2, w, h);
    }
    
    if ( drawingMode == "line") {
      line(x1, y1, x2, y2);
    }
    
    if ( drawingMode == "initial") {
      fill(255, 255, 255);
      square(280, 80, 600);
    }
  }
  
  void setSelectedDrawingStyle() {
    strokeWeight(2);
    stroke(0, 0, 0);
    fill(255, 100, 100); 
  }

  void setDefaultDrawingStyle() {
    strokeWeight(1);
    stroke(0, 0, 0);
    fill(127, 127, 127);
  }
  
}
