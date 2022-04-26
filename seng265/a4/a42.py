#!/usr/bin/env python3
'''Asignment 4 second part'''
print(__doc__)

import random

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
        '''init method'''
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
    def setCNT(self,num: int)->None:
        '''set count number'''
        self.CNT = num
        
    def __repr__(self) -> str:
        '''get string of class'''
        return "{:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} "\
                .format(self.CNT, self.SHA, self.X, self.Y, self.RAD, self.RX,self.RY,self.W,self.H,self.R,self.G,self.B,self.OP) #format string for the table 


def main():
    '''main method'''
    artConfig= ArtConfig(XMAX=500,YMAX=500) #set size
    catgr = ["CNT","SHA","X","Y","RAD","RX","RY","W","H","R","G","B","OP"]
    
    print('{:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3}'.format(*catgr))#pring category
    for i in range(10):
        myrand = GenRandom(artConfig)
        myrand.setCNT(i)
        print(myrand)
        
main()