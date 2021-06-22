public privileged aspect Behavior{
	
    //Q4: Shape Interface implementation
    declare parents : Rectangle implements Shape;
    declare parents : Circle implements Shape;

    public String Rectangle.getName(){
        return "Rectangle";
    }

    public String Circle.getName(){
        return "Circle";
    }

    //Q5: getName() methods implementation
    public String Rectangle.toString(){
        return this.getName() + "(" + this.width + ", " + this.height + ")";
    }

    public String Circle.toString(){
        return this.getName() + "(" + this.radius + ")";
    }

    //Q6: Circle getArea() method implementation
    double around(Circle c) : execution(double Circle.getArea()) && target(c){
    	return c.radius * c.radius * Math.PI;
    }

    //Q7: Negative value handling for getPerimeter() and getArea() methods
     double around(Circle c): (execution(double Circle.getPerimeter()) || execution(double Circle.getArea()) ) && target(c){
        if(c.radius <0) {
           return 0;
        }
        else {
        	return proceed(c);
        }
    }
     
     double around(Rectangle r): (execution(double Rectangle.getPerimeter()) || execution(double Rectangle.getArea())) && target(r){
         if(r.width<0 || r.height<0) {
            return 0;
         }
         else {
         	return proceed(r);
         }
     }

    

    //Q8: Identifiable Interface implementation
    private int shapeNo = 0;

    private int Rectangle.id;
    private int Circle.id;

    declare parents: Rectangle implements Identifiable;
    declare parents: Circle implements Identifiable;

    public int Rectangle.getId(){
        return this.id;
    }
    public int Circle.getId(){
        return this.id;
    }

    before(Circle c): execution(Circle.new(double)) && target(c){
        c.id = shapeNo;
        shapeNo++;
    }

    before(Rectangle r): execution(Rectangle.new(double, double)) && target(r){
        r.id = shapeNo;
        shapeNo++;
    }



}