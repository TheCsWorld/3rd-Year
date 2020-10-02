import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Queue;

public class DirectedAcyclicGraph {
	
	private final int V;
	private final ArrayList<Integer>[] adj;
	
	// For LCA
	private final ArrayList<Integer>[] reverseAdj;


public DirectedAcyclicGraph(int V)
{
	this.V = V;
	adj = (ArrayList<Integer>[]) new ArrayList[V];
	
	// For LCA
	reverseAdj = (ArrayList<Integer>[]) new ArrayList[V];
	
	for (int v = 0; v < V; v++)
	{
		adj[v] = new ArrayList<Integer>();
		
	
		//For LCA
		reverseAdj[v] = new ArrayList<Integer>();
	}
}

public boolean addEdge(int v, int w)
{
	// acyclic -> If will not create a cycle -> add edge
	// 1. not self loop
	// 2. !hasPath w -> v
	if(v >= this.V || w >= this.V || v < 0 || w < 0){ 
		return false;
	}
	

	if(v != w && !hasPath(w, v) && !adj[v].contains(w)){
		adj[v].add(w);
		reverseAdj[w].add(v);
		return true;
	}	
	else{
		return false;
	}
}

public int V(){
	return V;
}

public ArrayList<Integer> adj(int v)
{ return adj[v]; }

public ArrayList<Integer> reverseAdj(int v)
{ return reverseAdj[v]; }

public boolean hasPath(int x, int y){
	DirectedDFS dfsObj = new DirectedDFS(this, x);
	return dfsObj.visited(y);
}

public ArrayList<Integer> lowestCommonAncestor(int x, int y)
{
	
	//mark all X's parents
	//For each of X's parents, check if Y is child
	//if it is
	//{
	// get distance to X
	// distance to Y	
	// if max(xDist, yDist) < currentMaxDist
	// 		empty bag and put in this node
	//
	// if max(xDist, yDist) == currentMaxDist
	//		add this node to bag
	//}
	
	ArrayList<Integer> lcas = new ArrayList<Integer>();
	int currentMaxDist = Integer.MAX_VALUE;
	
	
	if(x==y || x>=this.V || y>=this.V || x<0 || y<0) { return lcas; } //If invalid input return empty bag.
	
	DirectedDFS dfsObject = new DirectedDFS(this, x);
	dfsObject.reverseDfs(this, x);
	int xDist, yDist;
	
	for(int v = 0; v < this.V; v++)
	{
	
		if(dfsObject.revVisited(v) && hasPath(v, y))
		{
			xDist = getDistance(v, x);
			yDist = getDistance(v, y);
			
			if(Integer.max(xDist, yDist) < currentMaxDist)
			{		
				lcas = new ArrayList<Integer>();
				lcas.add(v);
				currentMaxDist = Integer.max(xDist, yDist);
			}
			else if(Integer.max(xDist, yDist) == currentMaxDist)
			{
				lcas.add(v);
				currentMaxDist = Integer.max(xDist, yDist);
			}
		}
	}
	return lcas;
}

private int getDistance(int x, int target)
{
    
		if( x == target) { return 0; }
		else {
	        Queue<Integer> q = new LinkedList<Integer>();
	        int[] distTo = new int[this.V];
	        boolean[] marked = new boolean[this.V];
	        
	        for (int v = 0; v < this.V(); v++)
	        {   distTo[v] = Integer.MAX_VALUE;}
	        
	        distTo[x] = 0;
	        marked[x] = true;
	        q.add(x);
	
	        while (!q.isEmpty()) {
	            int v = q.remove();
	            for (int w : this.adj(v)) {
	                if (!marked[w]) {
	                	
	                	distTo[w] = distTo[v] + 1;
	                    marked[w] = true;
	                    
	                    q.add(w);
	                }
	            }
	        }
	        
	        return distTo[target];
		}
}

// Class to create a depth first search object on a directed graph.
private class DirectedDFS
{
	private boolean[] marked;
	private boolean[] revMarked;
	
	public DirectedDFS(DirectedAcyclicGraph G, int s)
	{
		marked = new boolean[G.V()];
		revMarked = new boolean[G.V()];
		dfs(G, s);
	}
	
	
	//standard dfs - in the flow of direction.
	private void dfs(DirectedAcyclicGraph G, int v)
	{
		marked[v] = true;
		for (int w : G.adj(v))
		if (!marked[w]) dfs(G, w);
	}
	
	
	//dfs against the flow of direction - used to find all parents.
	private void reverseDfs(DirectedAcyclicGraph G, int v)
	{
		revMarked[v] = true;
		for (int w : G.reverseAdj(v))
		if (!revMarked[w]) reverseDfs(G, w);
	}
	
	public boolean visited(int v)
	{ return marked[v]; }
	
	public boolean revVisited(int v)
	{ return revMarked[v]; }
}

}
