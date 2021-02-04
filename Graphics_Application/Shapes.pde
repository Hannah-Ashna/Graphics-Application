class Shape {
  
  String drawingMode = "";
  PVector pointA;
  PVector pointB;
  
  int R = r, G = g, B = b;
  int R2 = r2, G2 = g2, B2 = b2;
  int weight = thicknessVal;
  
  boolean isSelected = false;
  boolean isBeingDrawn = false;
  boolean curveReady = false;
  
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
  
  // Select a drawn shape object
  public boolean toggleSelect(PVector point) {
    UIRect selectionRegion = new UIRect(pointA, pointB);
    
    if (selectionRegion.isPointInside(point)) {
      this.isSelected = !this.isSelected;
      return true;
    }
    return false;
  }
  
  
  // Draw the shape object
  public void drawShapes() {
    float x1 = this.pointA.x;
    float y1 = this.pointA.y;
    float x2 = this.pointB.x;
    float y2 = this.pointB.y;
    float w = x2-x1;
    float h = y2-y1;
    
    ArrayList<PVector> points = new ArrayList<PVector>();
    //Add points for the curve
    points.add(new PVector(x1, y1));
    //points.add(new PVector(x2 + 80, y1 - 75));
    points.add(new PVector(x2 + 30, y2 +75));
    points.add(new PVector(x2, y2));
    
    
    if (this.isSelected) {
      setSelectedDrawingStyle();
    } else{
      setDefaultDrawingStyle(); 
    }
    
    if (drawingMode == "rect") {
      rect(x1, y1, w, h);
    }
    
    if (drawingMode == "ellipse") {
      ellipse(x1+ w/2, y1 + h/2, w, h);
    }
    
    if (drawingMode == "line") {
      line(x1, y1, x2, y2);
    }
    
    if (drawingMode == "curve") {
      romcatmullCurve(points);
      if (this.curveReady == true){
        endShape();
      }
    }
    
    // Not used due to Canvas issue -- See DrawingList initCanvas() method
    if ( drawingMode == "initial") {
      strokeWeight(2);
      stroke(0, 0, 0);
      fill(255, 255, 255);
      square(280, 80, 600);
    }
    
  }
  
  // Change the drawing style of selected shape objects
  void setSelectedDrawingStyle() {
    strokeWeight(2);
    stroke(0, 0, 0);
    fill(255, 100, 100); 
  }

  // Set the default drawing style based on user choice (RGB Knobs)
  void setDefaultDrawingStyle() {
    strokeWeight(weight);
    stroke(R, G, B);
    fill(R2, G2, B2);
  }
  
  // Using begin and end shape created a duplication issue
  // This boolean ensures that the shape is only ended once we're done with the curve
  public void drawCurve(){
    this.curveReady = true;
  }
  
}
