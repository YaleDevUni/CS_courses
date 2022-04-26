#!/usr/bin/env python3
'''Assignment 4 Part 1 '''
print(__doc__)

from typing import IO

import sys

class Circle:
    '''Circle class'''
    def __init__(self, cir: tuple, col: tuple)->None:
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
        self.rx: int = rec[0]
        self.ry: int = rec[1]
        self.width: int = rec[2]
        self.height: int = rec[3]
        self.red: int = col[0]
        self.green: int = col[1]
        self.blue: int = col[2]
        self.op: float = col[3]

class ProEpilogue:
    '''Information about html prologue and epilogue'''
    def __init__(self):
        '''init method'''
        pass
    def writeHTMLline(self,f: IO[str], t: int, line: str)->None:
         '''writeLineHTML method'''
         ts = "   " * t
         f.write(f"{ts}{line}\n")
        
    def writeHTMLepilogue(self,f: IO[str], winTitle: str)->None:
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
    
        

        
def drawCircleLine(f: IO[str], t: int, c: Circle)->None:
    '''drawCircle method'''
    ts: str = "   " * t
    line: str = f'<circle cx="{c.cx}" cy="{c.cy}" r="{c.rad}" fill="rgb({c.red}, {c.green}, {c.blue})" fill-opacity="{c.op}"></circle>'
    f.write(f"{ts}{line}\n")
    
def drawRectangleLine(f: IO[str], t: int, r: Rectangle)->None:
    '''drawCircle method'''
    ts: str = "   " * t
    line: str = f'<rect width="{r.width}" height="{r.height}" fill="rgb({r.red}, {r.green}, {r.blue})" fill-opacity="{r.op}"></rect>'
    f.write(f"{ts}{line}\n")
        
def genArt(f: IO[str], t: int)->None:
   '''generate ART method'''
   drawRectangleLine(f, t, Rectangle((50,50,50,50), (255,0,0,1.0)))
   drawCircleLine(f, t, Circle((150,50,50), (255,0,0,1.0)))
   drawCircleLine(f, t, Circle((250,50,50), (255,0,0,1.0)))
   drawCircleLine(f, t, Circle((350,50,50), (255,0,0,1.0)))
   drawCircleLine(f, t, Circle((450,50,50), (255,0,0,1.0)))
   drawCircleLine(f, t, Circle((50,250,50), (0,0,255,1.0)))
   drawCircleLine(f, t, Circle((150,250,50), (0,0,255,1.0)))
   drawCircleLine(f, t, Circle((250,250,50), (0,0,255,1.0)))
   drawCircleLine(f, t, Circle((350,250,50), (0,0,255,1.0)))
   drawCircleLine(f, t, Circle((450,250,50), (0,0,255,1.0)))

def writeHTMLline(f: IO[str], t: int, line: str)->None:
     '''writeLineHTML method'''
     ts = "   " * t
     f.write(f"{ts}{line}\n")

def writeHTMLfile()->None:
    '''writeHTMLfile method'''
    fnam: str = "myPart1Art.html"
    winTitle = "My Art"
    f: IO[str] = open(fnam, "w")
    ProEpilogue().writeHTMLepilogue(f, winTitle) #write epilogue for html
    ProEpilogue().openSVGcanvas(f, 1, (500,300)) #write open part of Svg 
    genArt(f, 2) #generate art
    ProEpilogue().writeHTMLprologue(f, 1) #write prorogue and close svg
    f.close()

def main()->None:
    '''main method'''
    writeHTMLfile()

main()

                                                                                                                                                                                                                                                                                                        
