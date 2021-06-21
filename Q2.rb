$id = 0

class Shape
    attr_reader:id
    attr_accessor:name
    def initialize
        $id += 1
        @name = "Shape"
    end
        
    def print
        printf("%d: %s", $id, @name)
    end
    
    def perimeter
        printf(", perimeter: undefined")    
    end
    
    def area
        printf(", area: undefined\n")
    end
end 

class Circle < Shape
    def initialize(input_radius)
        $id += 1
        @radius = input_radius
        @name = "Circle"
        if(@radius < 0)
            puts "Error: Invalid Circle"
        end
    end
    
    def perimeter
        if(@radius < 0)
            printf(", perimeter: undefined")
        else
            @p = 2*Math::PI*@radius
            printf(", perimeter: %.5f", @p)
        end
    end
    
    def area
        if(@radius < 0)
            printf(", perimeter: undefined")
        else
            @r = @radius*@radius*Math::PI
            printf(", area: %.5f\n", @r)
        end
    end
end

class Ellipse < Shape
    def initialize(a, b)
        if(a >= b)
            @semi_major = a
            @semi_minor = b
        else
            @semi_major = b
            @semi_minor = a
        end
        $id += 1
        @name = "Ellipse"
        if(@semi_minor < 0 || @semi_major < 0)
            puts "Error: Invalid Ellipse"
        end
    end
    
    def area
        if(@semi_minor < 0 || @semi_major < 0)
            puts ", area: undefined"
        else
            @a = Math::PI*@semi_major*@semi_minor
            printf(", area: %.5f\n", @a)
        end
    end
    
    def eccentricity
        if(@semi_minor >= 0 && @semi_major >= 0)
            begin
                @c = Math.sqrt(@semi_major**2 - @semi_minor**2)
                printf("   linear eccentricity: %.5f\n", @c)
            rescue
                puts "Can't take the square root of a negative number"
                exit
            end
        end
    end
end

class Rhombus < Shape
    def initialize(new_d1, new_d2)
        @d1 = new_d1
        @d2 = new_d2
        $id += 1
        @name = "Rhombus"
        if(@d1 < 0 || @d2 < 0)
            puts "Error: Invalid Rhombus"
        end
    end
    
    def perimeter
        if(@d1 < 0 || @d2 < 0)
            printf(", perimeter: undefined")
        else
            @side = (Math.sqrt(@d1**2 + @d2**2))/2.0
            @s = 4.0*@side
            printf(", perimeter: %.5f", @s)
        end
    end
    
    def area
        if(@d1 < 0 || @d2 < 0)
            printf(", area: undefined")
        else
            @a = (@d1*@d2)/2.0
            printf(", area: %.5f\n", @a)
        end
    end
    
    def inradius
        if(@d1 >= 0 || @d2 >= 0)
            begin
                @r = (@d1*@d2)/(2.0*Math.sqrt((@d1**2)+(@d2**2)))
                printf("   inradius: %.5f\n", @r)
            rescue    
                puts "Can't divide by 0 or take the square root of a negative number"
                exit 
            end
        end
    end
end

IO.foreach('shapes.txt') do |line|
    a = line.split(" ")
    if(a[0] == "shape")
        s = Shape.new
        s.print
        s.perimeter
        s.area
    elsif(a[0] == "circle")
        c = Circle.new(a[1].to_i)
        c.print
        c.perimeter 
        c.area
    elsif(a[0] == "ellipse")
        e = Ellipse.new(a[1].to_i, a[2].to_i)
        e.print
        e.perimeter
        e.area
        e.eccentricity
    elsif(a[0] == "rhombus")
        r = Rhombus.new(a[1].to_i,a[2].to_i)
        r.print
        r.perimeter
        r.area
        r.inradius
    else
        puts "Invalid Shape"
    end
end