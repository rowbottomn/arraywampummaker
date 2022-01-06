import processing.sound.*;

/*Wampum Maker
  Nathan Rowbottom
  Jan 4 2022
  Features:
  +Can click to change color of beads
  +a click sound effect
  +Wipe button
  
  ToDo:
  
  *Save as a png.
  *Draggable "painting" of beads
  
  *Add the option of images rather than colors
  *Wampum belt is moved away from the edge of the screen
  *Load / Save belts as text files
  
*/

int [][] coords;
float beadW = 25;
float beadH = 3*beadW;
color [] colors;
SoundFile click;

void setup() {
  size(1600, 800);
  colors = new color[3];
  colors[0] = color(128, 128, 128);//default color
  colors[1] = color(40, 10, 60);//purple color
  colors[2] = color(255);//white color
  fill(colors[1]);
  
  coords = new int [5][50];

  for (int i = 0; i < coords.length; i++) {//this goes through all the rows (y)
    for (int j = 0; j < coords[0].length; j++) {//this goes through all the columns (x)
      
      rect(j*beadW, i*beadH, beadW, beadH);
    }
  }
  
  click = new SoundFile(this,"click1.mp3");
  click.amp(0.1);
}

void keyReleased(){
  if(key == 'd'){
    coords = new int [5][50];
  }
}

void mouseClicked(){
  //check to see if the mouse position is inside an element of the array
  for (int i = 0; i < coords.length; i++) {
    for (int j = 0; j < coords[0].length; j++) {

      if((mouseX>j*beadW&&mouseX<(j+1)*beadW) && (mouseY>i*beadH&&mouseY<(i+1)*beadH)){
        //print(j+", "+ i);
        coords[i][j]++;
        click.play();
        if(coords[i][j]>=colors.length){
          coords[i][j]=0;
        }
      }
      //rect(j*beadW, i*beadH, beadW, beadH);
    }
  }
}

int lastJ = -1;
int lastI = -1;
void mouseDragged(){
  //check to see if the mouse position is inside an element of the array
  for (int i = 0; i < coords.length; i++) {
    for (int j = 0; j < coords[0].length; j++) {
      //is the mouse inside the specific bead?
      if((mouseX>j*beadW&&mouseX<(j+1)*beadW) && (mouseY>i*beadH&&mouseY<(i+1)*beadH)){
        //print(j+", "+ i);
        if (j == lastJ && i == lastI ){//check to see if we are still in the same bead for dragging
          return;
        }
        else{
          lastJ = j;//update current bead we are dragging in
          lastI = i;
        }
        
        coords[i][j]++;
        //click.play();
        if(coords[i][j]>=colors.length){
          coords[i][j]=0;
        }
      }

    }
  }
}

void draw() {
  //clear the last frame
  background(0);

  //update


  //check

  //draw
  for (int i = 0; i < coords.length; i++) {
    for (int j = 0; j < coords[0].length; j++) {

      //get the color that corresponds to this element (j, i) of the 2D array
      /*int tempInt = coords[i][j]; 
      color tempCol = colors[tempInt];
      fill(tempCol);*/
      
      fill(colors[coords[i][j]]);
      rect(j*beadW, i*beadH, beadW, beadH, 4);
    }
  }
}
