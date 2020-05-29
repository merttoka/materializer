
float max_stroke_height = 0;
float smooth_stroke = 3.01;

//
//
class Stroke {

  // 
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  
  //
  PShape shape;
  BBox bb;
  
  // rendering
  color c = color(0, 255, 255);
  float stroke_weight = 4;
  
  //
  public Stroke() {
    shape = createShape();
  }
  
  // writes vertices into PShape in world coordinates 
  public void UpdateShape() {
    shape = createShape();
    shape.beginShape();
    shape.noFill();
    for(int i=0; i<vertices.size();i++) {
      PVector _p = vertices.get(i);
      shape.vertex(b2w(_p.x),b2w(_p.y),b2w(_p.z));  
    } 
    shape.endShape();
  }
  
  // stores point in bed coordinates
  public void AddVertex(float x, float y, float z) {
    if(z>max_stroke_height) max_stroke_height=z;
    
    PVector pos = new PVector(x,y,z);
    if(vertices.size() > 0) {
      PVector prev = vertices.get(vertices.size()-1);
      if(prev.dist(pos) > smooth_stroke) { // if its not too close to the previous vertex
        vertices.add(pos);    
      }
    }
    else vertices.add(pos);
  }
  
  //
  public void Draw() {
    UpdateShape();
    
    shape.setStroke(c);
    shape.setStrokeWeight(stroke_weight);
    shape(this.shape, 0, 0);
  }
  
  //
  public float GetHeight() {
    if(vertices.size() > 0)
      return vertices.get(0).z; 
    return 0;
  }
}