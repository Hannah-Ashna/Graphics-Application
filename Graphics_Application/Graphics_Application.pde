SimpleUI myUI;

void setup(){
  size(800,600);
  // instantiate the UI
  myUI = new SimpleUI();
  
  myUI.addPlainButton("hello", 100,100);
  
  
}


void draw(){
  
  // you MUST update the UI in draw() like so
  myUI.update();
  
}


// you MUST have this function declared.. it receives all the user-interface events
void handleUIEvent(UIEventData uied){
  // here we just get the event to print its self
  // with "verbosity" set to 1, (2 = medium, 3 = high, 0 = do not print anything)
  uied.print(1);
  
}
