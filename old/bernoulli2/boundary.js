// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//modified by Savva Madar about 99%

// A fixed boundary class

// A boundary is a polygonshape rectangle with x,y,width,and height and angle
function Boundary(zx_,zy_, ox_, oy_) {
	//get center of drawing
	var myVerts=[];
	var shouldAngleBeNegative=false;
	var zxBigger=0;
	var zyBigger=0;
	var centerX=0;
	if(zx_<ox_){
		centerX=((ox_-zx_)/2+zx_);
	}
	else{
		zxBigger=1;
		centerX=((zx_-ox_)/2+ox_);
	}
	var centerY=0;
	if(zy_<oy_){
		centerY=((oy_-zy_)/2+zy_);
	}
	else{
		zyBigger=1;
		centerY=((zy_-oy_)/2+oy_);
	}
	var w;//to get the width we need to make a triangle based on the lowest x with biggest y then make a right angled triangle  with imaginary biggest x and biggest y up to smallest x
	var lowestX = 0;
	var biggestX = 0;
	var biggestY = 0;
	var lowestY = 0;
	if(zxBigger==1){
		if(zyBigger==0){
			shouldAngleBeNegative=true;
		}
		lowestX = ox_;
		biggestX = zx_;
	}
	else{
		if(zyBigger==1){
			shouldAngleBeNegative=true;
		}
		lowestX = zx_;
		biggestX = ox_;
	}
	if(zyBigger==1){
		biggestY = zy_;
		lowestY = oy_;	
	}
	else{
		biggestY = oy_;
		lowestY = zy_;
	}
	var xdif = abs(zx_-ox_);
	var ydif = abs(zy_-oy_);
	w = sqrt((xdif*xdif)+(ydif*ydif));
	var angle1 = asin(ydif/w);
	var h=0.4;//this is a constant
	if(isNaN(angle1)==true){
	return;
      }
	var fd = new box2d.b2FixtureDef();
    fd.density = 1.0;
    fd.friction = 0.5;
    fd.restitution = 0.2;
    var f = new box2d.b2Fixture();

    var bd = new box2d.b2BodyDef();
    bd.type = box2d.b2BodyType.b2_staticBody;
    bd.position.x = scaleToWorld(centerX);
    bd.position.y = scaleToWorld(centerY);
//bd.fixedRotation=false;
if(shouldAngleBeNegative==false){
bd.angle = angle1;
}
else{
bd.angle = -angle1;
}
//bd.fixedRotation=true;
fd.shape = new box2d.b2PolygonShape();
fd.shape.SetAsBox(w/(scaleFactor*2), h/(scaleFactor*2), box2d.b2Vec2(centerX,centerY),0);
var myBody = world.CreateBody(bd);
myBody.CreateFixture(fd);
this.body = myBody;


  // Draw the boundary note how it uses an angle
  this.display = function() {
	var pos = scaleToPixels(this.body.GetPosition());
    // Draw it!
    rectMode(CENTER);
    push();
    translate(pos.x,pos.y);
	if(shouldAngleBeNegative==false){
		rotate(angle1);
	}
	else{
		rotate(-angle1);
	}
    fill(127);
    stroke(0);
    rect(0, 0, w, h);
    pop();
  }
}