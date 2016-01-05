/* @pjs globalKeyEvents="true"; */
/* @pjs pauseOnBlur="true"; */

// Bellicose Birds code by Chris Orban

// Some code in this file is from LGPL licenced code 
// that accompanied Daniel Shiffman's Nature of Code 2011 book
// http://www.shiffman.net

// Size of the ship
float r = 12;

boolean showarrows = true;

// Draw the ship and other stuff
void display() { 
//    wrapEdges();
    background(255);
    stroke(0);
    strokeWeight(2);
    /*
    pushMatrix();
    translate(x,y);
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
*/
    fill(0);
    text("left right arrows to turn, tap up arrow to thrust, press H to hide the arrows, press U to un-hide",10,10);
    image(img,x-12,y-12,25,25);
    if ( key == 'h') {
    showarrows = false;
    } else if (key == 'u') {
    showarrows = true;
    }
    int tri_width=7;
    if (showarrows) {    
    int x_line=10;
    int y_line=25;
    int line_len=100;
    line(x_line,y_line,x_line,y_line+line_len);
    line(x_line,y_line,x_line+line_len,y_line);
    triangle(x_line-tri_width/2,y_line+line_len,x_line+tri_width/2,y_line+line_len,x_line,y_line+line_len+10);
    triangle(x_line+line_len,y_line-tri_width/2,x_line+line_len,y_line+tri_width/2,x_line+line_len+10,y_line);
    text("+x",x_line+line_len+12,y_line);
    text("+y",x_line,y_line+line_len+25);
    }

    // Draw velocity arrow
    float v_scaling=1.0;
    stroke(255,0,0); // makes the line red
    strokeWeight(3); // makes the line thicker

    if ( ((vx != 0) || (vy != 0)) && showarrows) {
    line(x,y,x+v_scaling*vx,y+v_scaling*vy);
    float vel_angle = -atan2(vy,vx);
    fill(255,0,0); // makes the triangle red
    triangle(x+v_scaling*vx+sin(vel_angle)*tri_width/2,y+v_scaling*vy+cos(vel_angle)*tri_width/2,x+v_scaling*vx-sin(vel_angle)*tri_width/2,y+v_scaling*vy-cos(vel_angle)*tri_width/2,x+v_scaling*vx+cos(vel_angle)*10,y+v_scaling*vy-sin(vel_angle)*10);
    }

    // Draw force arrow
    float f_scaling=2.0;
    float Fx = mass*deltaVx/dt;
    float Fy = mass*deltaVy/dt;
    float f_angle = -atan2(Fy,Fx);

    if (((Fx != 0) || (Fy != 0)) && showarrows) {
    stroke(0,0,255); // makes the line blue
    line(x,y,x+f_scaling*Fx,y+f_scaling*Fy);
    fill(0,0,255); // makes the triangle blue
    triangle(x+f_scaling*Fx+sin(f_angle)*tri_width/2,y+f_scaling*Fy+cos(f_angle)*tri_width/2,x+f_scaling*Fx-sin(f_angle)*tri_width/2,y+f_scaling*Fy-cos(f_angle)*tri_width/2,x+f_scaling*Fx+cos(f_angle)*10,y+f_scaling*Fy-sin(f_angle)*10);
    }

    float a_scaling=f_scaling;
    float ax = deltaVx/dt;
    float ay = deltaVy/dt;
    if (((ax != 0) || (ay != 0)) && showarrows) {
    stroke(204,0,204); // makes the line purple
    line(x,y,x+a_scaling*ax,y+a_scaling*ay);
    fill(204,0,204); // makes the triangle purple
    triangle(x+a_scaling*ax+sin(f_angle)*tri_width/2,y+a_scaling*ay+cos(f_angle)*tri_width/2,x+a_scaling*ax-sin(f_angle)*tri_width/2,y+a_scaling*ay-cos(f_angle)*tri_width/2,x+a_scaling*ax+cos(f_angle)*10,y+a_scaling*ay-sin(f_angle)*10);
    }

    if (showarrows) {
    textSize(20);
    fill(255,0,0);
    text("Velocity",10,425);
    fill(0,0,255);
    text("Force",10,450);
    fill(204,0,204);
    text("Acceleration",10,475);
    }

    fill(0,0,0); //If more text is written elsewhere make sure the default is black
    stroke(0,0,0); // If more lines are drawn elsewhere make sure the default is black
    
}


void wrapEdges() {
    float buffer = r*2;
    if (x > width +  buffer) x = -buffer;
    else if (x <    -buffer) x = width+buffer;
    if (y > height + buffer) y = -buffer;
    else if (y <    -buffer) y = height+buffer;
}


/*
 * BaseGraph
 * This code is part of a processing graph system developed for usage by physicshacker.com
 *
 * Copyright (C) 2015 Christopher Britt
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

// The base graph class. 
class BaseGraph{
  protected ArrayList<Line> m_lines = new ArrayList<Line>();
  protected ArrayList<Line> m_lines_axis = new ArrayList<Line>();
  protected ArrayList<Line> m_lines_border = new ArrayList<Line>();
  
  protected int m_x = 0;
  protected int m_y = 0;
  
  protected int m_size_x = 0;
  protected int m_size_y = 0;
  
  public int fontSize = 25;
  
  // The thickness of the line to be drawn. 
  public int thicknessFunction = 1;
  public int thicknessAxis = 1;
  public int thicknessBorder = 1;
  
//  public String xTitle = new String("X Axis");
//  public String yTitle = new String("Y Axis");
  public String xTitle = new String("");
  public String yTitle = new String("");
  
  
  // The color of the line to be drawn. 
  public color colorFunction = color(0,0,0);
  public color colorAxis = color(0,0,0);
  public color colorBorder = color(0,0,0);
  
  // Will the system draw axis
  public boolean drawAxis = true;
  
  // Will draw a box around the area
  public boolean drawBorder = false;
  
  public void setPosition(int _x, int _y){
    m_x = _x;
    m_y = _y;
  }
  
  public void setSize(int _size_x, int _size_y){
    m_size_x = _size_x;
    m_size_y = _size_y;
  }
  
  // The overall control functions
  
  // This function serves to calculate the the line. This will only need to be run if the
  // function or drawing paramaters have been changed. 
  //public void calculate() {}
  
  public void setTitle(){
    textSize(fontSize);
    fill(0,0,0);
    text(xTitle, (float)(m_x + m_size_x - xTitle.length()*fontSize/2), (float)(m_y + m_size_y + 25));
    text(yTitle, (float)(m_x - 25), (float)(m_y + fontSize));
  }
  
  // This function serves to draw the current graph on the screen. 
  public void display(){
    // Draw the axis of the graph.
    strokeWeight(thicknessAxis);
    stroke(colorAxis);
    for(int i = 0; i < m_lines_axis.size(); ++i){
      m_lines_axis.get(i).display();
    }
    
    // Draw the border of the graph.
    strokeWeight(thicknessBorder);
    stroke(colorBorder);
    for(int i = 0; i < m_lines_border.size(); ++i){
      m_lines_border.get(i).display();
    }
    
    // Draw the function on the graph. 
    strokeWeight(thicknessFunction);
    stroke(colorFunction);
    for(int i = 0; i < m_lines.size(); ++i){
      m_lines.get(i).display();
    }
  }
  
  public void draw(){
    display();
    setTitle();
  }
    
}

/*
 * DPGraph
 * This code is part of a processing graph system developed for usage by physicshacker.com
 *
 * Copyright (C) 2015 Christopher Britt
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

class DPGraph extends BaseGraph{
  
  protected ArrayList<Double> m_points = new ArrayList<Double>();
  
  public double maxMarginPercent = 1.4;
  
  public boolean logScaling = false;
    
  public void clearData(){
    m_points.clear();
  }
  
  public void addPoint(double _p){
    m_points.add(_p);
  }
  
    public void display(){
    m_lines.clear();
    m_lines_axis.clear();
    m_lines_border.clear();
        
    // Parse the size to a double, and store this data. 
    double dSizeX = (double)m_size_x;
    double dSizeY = (double)m_size_y;
    
    double incX = ((double)m_points.size()) / dSizeX;
      
    // The max/min y values. 
    double maxY = 0;
    double minY = 0;
    
    for( int i = 0; i < m_points.size(); ++i){
      if(m_points.get(i) > maxY) maxY = m_points.get(i);
      if(m_points.get(i) < minY) minY = m_points.get(i);
    }
        
    minY *= maxMarginPercent;
    maxY *= maxMarginPercent;
    
    //double incY = 0.5*dSizeY /abs((float)(maxY-minY));

    // If the axis needs to be drawn, add the necessary lines to the queue. 
    if(drawAxis){
      // draw y-axis
      m_lines_axis.add(new Line(m_x,m_y,m_x,m_y+m_size_y));
      // draw x-axis
      m_lines_axis.add(new Line(m_x,m_y+m_size_y,m_x+m_size_x,m_y+m_size_y));
    }
    
    // If the border needs to be drawn, add the necessary lines to the queue. 
    if(drawBorder){
      m_lines_border.add(new Line(m_x,m_y,m_x+m_size_x,m_y));
      m_lines_border.add(new Line(m_x,m_y+m_size_y,m_x+m_size_x,m_y+m_size_y));
      m_lines_border.add(new Line(m_x,m_y,m_x,m_y+m_size_y));
      m_lines_border.add(new Line(m_x+m_size_x,m_y,m_x+m_size_x,m_y+m_size_y));
    }
    
    int oxi = 0;
    int oyi = 0;
    int opos = 1;
    
    boolean shouldSkip = true;
    
    // Draw the shape
    for( int xi = 0; xi <= m_size_x; ++xi){
      double dX = xi;
      int pos = (int)(dX * incX);
    /*    
      if (pos == opos) {
        shouldSkip = true;
        continue;
      } else opos = pos;
      */
      
      // If the index is oob, skip. 
      if(pos >= m_points.size()) continue;
      
//      int yi = (int)(-0.5 * m_size_y * (m_points.get(pos) - 0.5*(maxY+minY))/(0.5*(abs((float)(maxY-minY)))));
      int yi = (int)((-m_size_y*m_points.get(pos)/(0.5*mass*vinit*vinit))/maxMarginPercent);    
      // Skip the first iteration as no previous value has been ascertained. 
      if(!shouldSkip) {
        int x1 = oxi+m_x;
        int y1 = oyi + m_y + m_size_y;
        int x2 = xi+m_x;
        int y2 = yi + m_y + m_size_y;
              
        // Check for conditions where the line is out of bounds. 
     /*  
        if(x1<m_x||x1>m_x+m_size_x){
          shouldSkip = true;
          continue;
        }
        if(x2<m_x||x2>m_x+m_size_x){
          shouldSkip = true;
          continue;
        }
        if(y1<m_y||y1>m_y+m_size_y){
          shouldSkip = true;
          continue;
        }
        if(y2<m_y||y2>m_y+m_size_y){
          shouldSkip = true;
          continue;
        }
     */   
        // If all checks succeeded, add the line to the queue to be drawn. 
        m_lines.add(new Line(x1, y1, x2, y2));
      }else{
        shouldSkip = false;
      }
      
      // Update the old position. 
      oxi = xi;
      oyi = yi;
    }
    
    shouldSkip = true;
   
  draw();
  setTitle();
  }//display()
  
    // This function serves to draw the current graph on the screen. 
  public void draw(){
    // Draw the axis of the graph.
    strokeWeight(thicknessAxis);
    stroke(colorAxis);
    for(int i = 0; i < m_lines_axis.size(); ++i){
      m_lines_axis.get(i).display();
    }
    
    // Draw the border of the graph.
    strokeWeight(thicknessBorder);
    stroke(colorBorder);
    for(int i = 0; i < m_lines_border.size(); ++i){
      m_lines_border.get(i).display();
    }
    
    // Draw the function on the graph. 
    strokeWeight(thicknessFunction);
    stroke(colorFunction);
    for(int i = 0; i < m_lines.size(); ++i){
      m_lines.get(i).display();
    }
    
  }//draw()
 
}

class CPoint{
  public double x, y;
  CPoint(double _x, double _y){
    x = _x;
    y = _y;
  }
}

// The object to store the information of a line to be drawn. 
class Line{
  int x1 = 0;
  int x2 = 100;
  int y1 = 0;
  int y2 = 100;
  
  Line(int _x1, int _y1, int _x2, int _y2){
    x1 = _x1;
    x2 = _x2;
    y1 = _y1;
    y2 = _y2;
  }
  
  Line(CPoint _p1, CPoint _p2){
    x1 = (int)_p1.x;
    y1 = (int)_p1.y;
    
    x2 = (int)_p2.x;
    y2 = (int)_p2.y;
  }
  
  void display(){
    line(x1,y1,x2,y2);
  }
}