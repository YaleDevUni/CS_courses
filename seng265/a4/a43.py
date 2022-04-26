#!/usr/bin/env python3
'''Asignment 4 third part'''
print(__doc__)

import random
from typing import IO, Tuple
class ArtConfig:
    '''Range of geometric shape'''
    def __init__(self,XMAX: int, YMAX: int,
                SHAMIN: int = 0,SHAMAX: int = 3,
                XMIN: int = 0, YMIN: int =0,
                RADMIN: int=0,RADMAX: int=100,
                RXMIN: int =10,RXMAX:int =30,
                RYMAX:int=30,RYMIN:int=10,
                WMAX:int = 100,WMIN:int=10,
                HMIN:int=10,HMAX:int=100,
                REDMAX:int=255,REDMIN:int=0,
                BLUEMAX:int=255,BLUEMIN:int=0,
                GREENMAX:int=255,GREENMIN:int=0,
                OPMAX:float=1.0,OPMIN:float=0) -> None:
        self.SHAMIN: int = SHAMIN
        self.SHAMAX: int = SHAMAX
        self.XMIN: int = XMIN
        self.XMAX: int = XMAX
        self.YMIN: int =YMIN
        self.YMAX: int=YMAX
        self.RXMIN: int= RXMIN
        self.RXMAX: int=RXMAX
        self.RYMIN: int= RYMIN
        self.RYMAX: int= RYMAX
        self.RADMIN: int=RADMIN
        self.RADMAX: int=RADMAX
        self.WMAX:int = WMAX
        self.WMIN:int=WMIN
        self.HMIN:int=HMIN
        self.HMAX:int=HMAX
        self.REDMAX:int=REDMAX
        self.REDMIN:int=REDMIN
        self.BLUEMAX:int=BLUEMAX
        self.BLUEMIN:int=BLUEMIN
        self.GREENMAX:int=GREENMAX
        self.GREENMIN:int=GREENMIN
        self.OPMAX:float=OPMAX
        self.OPMIN:float=OPMIN

class GenRandom:
    ''' Generate Random properties by given Configuration'''
    def __init__(self,AC:ArtConfig)->None:
        '''init class method'''
        self.CNT: int = 0
        self.SHA: int = random.randint(AC.SHAMIN,AC.SHAMAX)
        self.X: int = random.randint(AC.XMIN,AC.XMAX)
        self.Y: int = random.randint(AC.YMIN,AC.YMAX)
        self.RAD: int = random.randint(AC.RADMIN,AC.RADMAX)
        self.RX: int = random.randint(AC.RXMIN,AC.RXMAX)
        self.RY: int = random.randint(AC.RYMIN,AC.RYMAX)
        self.W: int = random.randint(AC.WMIN,AC.WMAX)
        self.H: int = random.randint(AC.HMIN,AC.HMAX)
        self.R: int = random.randint(AC.REDMIN,AC.REDMAX)
        self.G: int = random.randint(AC.GREENMIN,AC.GREENMAX)
        self.B: int = random.randint(AC.BLUEMIN,AC.BLUEMAX)
        self.OP: float = round(random.uniform(AC.OPMIN, AC.OPMAX), 1)
        
    def getCircle(self)->tuple:
        '''get circle property as tuple'''
        return (self.X,self.Y,self.RAD)
    
    def getRectangle(self)->tuple:
        '''get rectangle property as tuple'''
        return(self.X,self.Y,self.W,self.H)
    
    def getEllipse(self)->tuple:
        '''get ellipse property as tuple'''
        return(self.X,self.Y,self.RX,self.RY)
    
    def getColor(self)->tuple:
        '''get rectangle property as tuple'''
        return(self.R,self.G,self.B,self.OP)
        
    def setCNT(self,num: int)->None:
        '''set count method'''
        self.CNT = num

    def __repr__(self) -> str:
        '''get string class'''
        return "{:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} "\
                .format(self.CNT, self.SHA, self.X, self.Y, self.RAD, self.RX,self.RY,self.W,self.H,self.R,self.G,self.B,self.OP) #formating for the table

class Circle:
    '''Circle class'''
    def __init__(self, cir: tuple, col: tuple)->None:
        '''init class method'''
        self.cx: int = cir[0]
        self.cy: int = cir[1]
        self.rad: int = cir[2]
        self.red: int = col[0]
        self.green: int = col[1]
        self.blue: int = col[2]
        self.op: float = col[3]
class Rectangle:
    '''Rectangle class'''
    def __init__(self, rec: tuple, col: tuple)->None:
        '''init class method'''
        self.rx: int = rec[0]
        self.ry: int = rec[1]
        self.width: int = rec[2]
        self.height: int = rec[3]
        self.red: int = col[0]
        self.green: int = col[1]
        self.blue: int = col[2]
        self.op: float = col[3]
class Ellipse(Circle): #derived from circle class
    '''Ellipse class'''
    def __init__(self, cir: tuple, col: tuple)->None: 
        '''init class method'''
        super().__init__(cir, col)
        self.rx: int = cir[2]
        self.ry: int = cir[3]

class ProEpilogue:
    '''Information about html prologue and epilogue'''
    def __init__(self)->None:
        '''init class method'''
        pass
    
    def writeHTMLline(self,f: IO[str], t: int, line: str)->None:
         '''writeLineHTML method'''
         ts = "   " * t
         f.write(f"{ts}{line}\n")
        
    def writeHTMLepilogue(self,f: IO[str], winTitle: str):
        '''writeHeadHTML method'''
        self.writeHTMLline(f, 0, "<html>")
        self.writeHTMLline(f, 0, "<head>")
        self.writeHTMLline(f, 1, f"<title>{winTitle}</title>")
        self.writeHTMLline(f, 0, "</head>")
        self.writeHTMLline(f, 0, "<body>")
    
    def writeHTMLprologue(self,f: IO[str], t: int)->None:
        '''closeSVGcanvas method'''
        ts: str = "   " * t
        f.write(f'{ts}</svg>\n')
        f.write(f'</body>\n')
        f.write(f'</html>\n')
        
    def writeHTMLcomment(self,f: IO[str], t: int, com: str)->None:
        '''writeHTMLcomment method'''
        ts: str = "   " * t
        f.write(f'{ts}<!--{com}-->\n')
        
    def openSVGcanvas(self,f: IO[str], t: int, canvas: tuple)->None:
         '''openSVGcanvas method'''
         ts: str = "   " * t
         self.writeHTMLcomment(f, t, "Define SVG drawing box")
         f.write(f'{ts}<svg width="{canvas[0]}" height="{canvas[1]}">\n')
    
        
def drawRectangleLine(f: IO[str], t: int, r: Rectangle)->None:
    '''drawBOX method'''
    ts: str = "   " * t
    line: str = f'<rect x="{r.rx}" y="{r.ry}" width="{r.width}" height="{r.height}" fill="rgb({r.red}, {r.green}, {r.blue})" fill-opacity="{r.op}"></rect>'
    f.write(f"{ts}{line}\n")
        
def drawCircleLine(f: IO[str], t: int, c: Circle)->None:
    '''drawCircle method'''
    ts: str = "   " * t
    line: str = f'<circle cx="{c.cx}" cy="{c.cy}" r="{c.rad}" fill="rgb({c.red}, {c.green}, {c.blue})" fill-opacity="{c.op}"></circle>'
    f.write(f"{ts}{line}\n")

def drawEllipseLine(f: IO[str], t: int, c: Ellipse)->None:
    '''drawEllipse method'''
    ts: str = "   " * t
    line: str = f'<ellipse cx="{c.cx}" cy="{c.cy}" rx="{c.rx}" ry="{c.ry}" fill="rgb({c.red}, {c.green}, {c.blue})" fill-opacity="{c.op}"></ellipse>'
    f.write(f"{ts}{line}\n")

def genArt(f: IO[str], t: int,itr:int,myconfig: ArtConfig)->None:
   '''genART method'''
   for i in range(itr):
        mypoly = GenRandom(myconfig) #init random properties in range of configuration
        if mypoly.SHA == 0:
            drawCircleLine(f,t, Circle(mypoly.getCircle(),mypoly.getColor()))
        elif mypoly.SHA == 1:
            drawRectangleLine(f,t,Rectangle(mypoly.getRectangle(),mypoly.getColor()))
        else:
            drawEllipseLine(f,t,Ellipse(mypoly.getEllipse(),mypoly.getColor()))

        
def writeHTMLline(f: IO[str], t: int, line: str)->None:
     '''writeLineHTML method'''
     ts = "   " * t
     f.write(f"{ts}{line}\n")



def writeHTMLfile()->None:
    '''writeHTMLfile method'''
    fnam: str = "myPart3Art.html"
    winTitle = "My Art"
    x = 800
    y = 400
    myconfig= ArtConfig(x,y,OPMAX=.5,RADMAX=5)
    f: IO[str] = open(fnam, "w")
    ProEpilogue().writeHTMLepilogue(f, winTitle)
    ProEpilogue().openSVGcanvas(f, 1, (x,y))
    genArt(f, 2,itr = 1000,myconfig=myconfig)
    ProEpilogue().writeHTMLprologue(f, 1)
    f.close()





def main():
    '''main method'''
    writeHTMLfile()

main()