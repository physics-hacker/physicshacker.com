// Lunar Descent code by Chris Orban

float x;
float y;

float vx;
float vy;

float deltaVx;
float deltaVy;

float theta = 0;

float Fthrust = 30.0;
float mass = 3.0;
float dt = 0.1;

float g = 1.63;

void setup() {
  size(750,500);
  x = width/2;
  y = height/2;
}

// For people with C and C++ experience, draw() is
// very similar to main(), except that draw() 
// is run over and over again 
void draw() {
  
  // Update velocities
  vx += deltaVx;
  vy += deltaVy;

  // Update location
  x += vx*dt;
  y += vy*dt;

  // Set deltaV to zero (thrust off unless user turns it on)
  deltaVx = 0;
  deltaVy = 0;

  // Turn or thrust the ship depending on what key is pressed
  if (keyPressed) {
    if (key == CODED && keyCode == LEFT) {
      theta += 0.05;
    } else if (key == CODED && keyCode == RIGHT) {
      theta += -0.05;
    } else if (key == CODED &&  keyCode == UP ) {
      // Rockets on!
      float accelx = Fthrust*cos(theta)/mass;
      deltaVx = accelx*dt;
      float accely = -Fthrust*sin(theta)/mass;
      deltaVy = accely*dt;
    } else if (key == ' ') { // spacebar is pressed
      // Do nothing
    } 
  }

  // Add gravity, note that down is positive
  deltaVy += g*dt;

  if ( abs(y - 0.97*height)  < 0.1) {
    deltaVx = 0;
    deltaVy = 0;
    vx = 0;
    vy = 0;
    theta = PI/2;
  }

  // Draw ship and other stuff
  // This will clear the screen and re-draw it
  display();

  line(0,height,width,height);

  if (y > height) {
  text("Game Over!",width/2,height/2);
  noLoop();
  }

} // end draw()


