/* @pjs globalKeyEvents="true"; */

// Planetoids code by Chris Orban
// modified from Daniel Shiffman's Nature of Code 2011 book
// http://www.shiffman.net

// Size of the ship
float r = 12;

void setup() {
  int width = 750;
  int height = 500;
  size(width,height);
  smooth();
  x = width/2;
  y = height/2;
}

// Draw the ship and other stuff
void display() { 
    wrapEdges();
    background(255);
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(x,y+r);
    rotate(-theta+PI/2);
    fill(175);
    // A triangle
    beginShape();
    vertex(-r,r);
    vertex(0,-1.5*r);
    vertex(r,r);
    endShape(CLOSE);
    rectMode(CENTER);
    popMatrix();
    fill(0);
//    text("left right arrows to turn, tap up arrow to thrust",10,10);

    int offset=12;
    line(width/2,height/2+offset,width/2+50,height/2+offset);
/*
    int x_line=10;
    int y_line=25;
    int line_len=100;
    line(x_line,y_line,x_line,y_line+line_len);
    line(x_line,y_line,x_line+line_len,y_line);
    int tri_width=7;
    triangle(x_line-tri_width/2,y_line+line_len,x_line+tri_width/2,y_line+line_len,x_line,y_line+line_len+10);
    triangle(x_line+line_len,y_line-tri_width/2,x_line+line_len,y_line+tri_width/2,x_line+line_len+10,y_line);
    text("+x",x_line+line_len+12,y_line);
    text("+y",x_line,y_line+line_len+25);
*/
}


void wrapEdges() {
    float buffer = r*2;
    if (x > width +  buffer) x = -buffer;
    else if (x <    -buffer) x = width+buffer;
    if (y > height + buffer) y = -buffer;
    else if (y <    -buffer) y = height+buffer;
}

