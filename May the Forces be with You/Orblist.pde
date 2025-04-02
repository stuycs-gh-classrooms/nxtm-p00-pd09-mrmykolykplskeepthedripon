class OrbList {

  OrbNode front;
  OrbNode[] list, temp;
  int x = 10;
  
  OrbList() {
    front = null;
  }//constructor

  void addFront(OrbNode o) {
    if(front == null){
      front = o;
    }
    else{
      o.next = front;
      front.previous = o;
      front = o;
    }
  }//addFront

  void populate(int n, boolean ordered) {
    list = new OrbNode[n];
    for (int i = 0; i<list.length; i++) {
      list[i] = new OrbNode();
      addFront(list[i]);
      if (ordered) {
        list[i].center.x = x;
        x = x + SPRING_LENGTH;
      }
    }
  }//populate

  void display() {
    for (int i = 0; i< list.length; i++) {
      list[i].display();
    }
  }//display

  void applySprings(int springLength, float springK) {
    for (int i = 0; i< list.length; i++) {
      list[i].applySprings(springLength, springK);
    }
  }//applySprings

  void applyGravity(Orb other, float gConstant) {
    for (int i = 0; i< list.length; i++) {
      PVector gforce = list[i].getGravity(other, gConstant);
      list[i].applyForce(gforce);
    }
  }//applySprings
  
    void applyDrag(Orb other, float gConstant) {
    for (int i = 0; i< list.length; i++) {
      PVector dragForce = list[i].getDragForce(gConstant);
      list[i].applyForce(dragForce);
    }
  }
   
  void run(boolean bounce) {
    for (int i = 0; i<list.length; i++) {
      list[i].move(bounce);
    }
  }//applySprings

  void removeFront() {
    temp = new OrbNode[list.length-1];
    arrayCopy(list, 1, temp, 0, list.length-1);
    arrayCopy(temp, list);
    for (int i = 0; i<list.length-1; i++) {
      if (i == 0) {
        list[i].next = list[i+1];
      } else {
        list[i].next = list[i+1];
        list[i].previous = list[i-1];
      }
    }
  }//removeFront

  OrbNode getSelected(int x, int y) {
    for(int i = 0; i<list.length; i++){
      if(list[i].isSelected(x,y)){
        return list[i];
      }
    }
    return null;
  }//getSelected

  void removeNode(OrbNode o) {
    int re = 0;
    temp = new OrbNode[list.length-1];
    for(int i = 0; i< list.length;i++){
      if(list[i] == o){
        re = i;
      }
    }
    for(int i = 0; i< list.length;i++){
      if(i<re){
        temp[i] = list[i];
      }
      if(i>re){
        temp[i-1] = list[i];
      }
    }
  }
  
}//OrbList
