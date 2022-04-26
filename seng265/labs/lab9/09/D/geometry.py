# Fill your boots here...
import math
class Point:

    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y

    def __repr__(self):
        return "Point(%r, %r)" % (self.x,self.y)

    def translate(self,x=0,y=0):
        return Point(self.x+x,self.y+y)
    def delta_x(self, d):
        return Point(self.x+d, self.y)
    def delta_y(self, d):
        return Point(self.x, self.y+d)

class Circle:
    def __init__(self,p=Point(),r=0):
        self.p = p
        self.r = r
    def __repr__(self):
        return "Circle(%r, %r)" % (self.p,self.r)
    def perimeter(self):
        return math.pi*self.r*2
    def area(self):
        return math.pi*self.r**2
    def translate(self,dx,dy):
        return Circle(self.p.translate(dx,dy),self.r)
class Rectangle:
    def __init__(self,p1=Point(),p2=Point()):
        self.upper_left =p1
        self.lower_right =p2
    def __repr__(self):
        return "Rectangle(%r, %r)" % (self.upper_left,self.lower_right)
    def area(self):
        side1 = abs(self.upper_left.x-self.lower_right.x)
        side2 = abs(self.upper_left.y-self.lower_right.y)
        return side1*side2
    def perimeter(self):
        side1 = abs(self.upper_left.x-self.lower_right.x)
        side2 = abs(self.upper_left.y-self.lower_right.y)
        return side1*2+side2*2
    def translate(self,dx,dy):
        return Rectangle(self.upper_left.translate(dx,dy),self.lower_right.translate(dx,dy))
