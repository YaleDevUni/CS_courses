/*
	Name:
	Student ID: 
*/ 

import java.awt.Color;
import java.util.*;

public class GraphAlgorithms{

	/* FloodFillDFS(v, writer, fillColour)
	   Traverse the component the vertex v using DFS and set the colour 
	   of the pixels corresponding to all vertices encountered during the 
	   traversal to fillColour.
	   
	   To change the colour of a pixel at position (x,y) in the image to a 
	   colour c, use
			writer.setPixel(x,y,c);
	*/
	public static void FloodFillDFS(PixelVertex v, PixelWriter writer, Color fillColour){
		
		Stack<PixelVertex> stack = new Stack<PixelVertex>();
		stack.push(v);
		while(stack.empty() == false){
			v= stack.peek();
			stack.pop();
			writer.setPixel(v.getX(), v.getY(), fillColour);
			LinkedList<PixelVertex> neighbour = v.getNeighbours();
			while(!neighbour.isEmpty()){
				PixelVertex o = neighbour.pollFirst();
				stack.push(o);
			}
		}



		// LinkedList<PixelVertex> neighbour = v.getNeighbours();
		
		// while(!neighbour.isEmpty()){
		// 	//PixelVertex o = neighbour.getFirst();
		// 	PixelVertex o =neighbour.pollFirst();
		// 	FloodFillDFS(o, writer, fillColour);
		// }
		

		// TODO: implement this method
	}
	
	/* FloodFillBFS(v, writer, fillColour)
	   Traverse the component the vertex v using BFS and set the colour 
	   of the pixels corresponding to all vertices encountered during the 
	   traversal to fillColour.
	   
	   To change the colour of a pixel at position (x,y) in the image to a 
	   colour c, use
			writer.setPixel(x,y,c);
	*/
	public static void FloodFillBFS(PixelVertex v, PixelWriter writer, Color fillColour){
		
		LinkedList<PixelVertex> queue = new LinkedList<PixelVertex>();
		queue.add(v);
		while(queue.size()!=0){
			v = queue.poll();
			writer.setPixel(v.getX(), v.getY(), fillColour);
			LinkedList<PixelVertex> neighbour = v.getNeighbours();
			while(!neighbour.isEmpty()){
				PixelVertex o = neighbour.pollFirst();
				queue.add(o);
			}
		}
		// TODO: implement this method
	}
	
}