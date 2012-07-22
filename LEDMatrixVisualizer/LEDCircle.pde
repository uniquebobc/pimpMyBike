class LEDCircle {
  //pixels on Processing sketch
  int x0;
  int y0;
  int x1;
  int y1;
  //pixels on LED matrix
  int x0P;
  int y0P;
  //radius in Processing pixels 
  //and radius in LED pixels
  int r;
  int rP;
  //is the circle filled?
  boolean fillC;
  LinkedList<LEDPoint> LEDPoints = new LinkedList<LEDPoint>();
  
  public LEDCircle(int x, int y, boolean f){
    x0 = x;
    y0 = y;
    x1 = 0;
    y1 = 0;
    x0P = x0 / space;
    y0P = y0 / space;
    r = 0;
    rP = 0;
    fillC = f;
  }
  
  //x and y are mouseX and mouseY
  void setCircleCursor(int xt, int yt){
    LEDPoints.clear();
    x1 = xt;
    y1 = yt;
    r = int(sqrt((x0-x)*(x0-x) + (y0-y)*(y0-y)));
    rP = r/space;
     
    int f = 1 - rP;
    int ddF_x = 1;
    int ddF_y = -2 * rP;
    int x = 0;
    int y = r;
  
    addToShape(x0P, y0P+rP);
    addToShape(x0P, y0P-rP);
    addToShape(x0P+rP, y0P);
    addToShape(x0P-rP, y0P);
  
    while (x<y) {
      if (f >= 0) {
        y--;
        ddF_y += 2;
        f += ddF_y;
      }
      x++;
      ddF_x += 2;
      f += ddF_x;
    
      addToShape(x0P + x, y0P + y);
      addToShape(x0P - x, y0P + y);
      addToShape(x0P + x, y0P - y);
      addToShape(x0P - x, y0P - y);
      
      addToShape(x0P + y, y0P + x);
      addToShape(x0P - y, y0P + x);
      addToShape(x0P + y, y0P - x);
      addToShape(x0P - y, y0P - x);
    }
    if(fillC){
      setFill();
    }
  }
  
 void setFill(){
    int f = 1 - rP;
    int ddF_x = 1;
    int ddF_y = -2 * rP;
    int x = 0;
    int y = rP;
  
    for(int i = 0; i <= 2*rP+1; i++){
      addToShape(x0P, y0P-rP + i);
    }

    while (x<y) {
      if (f >= 0) {
        y--;
        ddF_y += 2;
        f += ddF_y;
      }
      x++;
      ddF_x += 2;
      f += ddF_x;
    
      for(int i = 0; i <= 2*y+1; i++){
        addToShape(x0P+x, y0P-y + i);
        addToShape(x0P-x, y0P-y + i);
      }
      for(int i = 0; i <= 2*x+1; i++){
        addToShape(x0P+y, y0P-x + i);
        addToShape(x0P-y, y0P-x + i);
      }
    }
  }
  
  void addToShape(int x, int y){
    LEDPoint p = new LEDPoint(x, y);
    LEDPoints.add(p);
  }
  
  boolean inCircle(int x, int y){
    for(int i = 0; i < LEDPoints.size(); i++){
      if(LEDPoints.get(i).equal(x, y)){
        return true;
      }
      else{
        return false;
      }
    }
  }  
}

