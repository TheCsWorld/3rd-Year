import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Test;

public class LCATest {
	
	@Test
	public void test0() {
		LCA tree = new LCA(); 
		
		assertEquals("Empty tree test", -1, tree.findLCA(4,5)); 
	}

	@Test
	public void test1() {
		LCA tree = new LCA(); 
		tree.root = new Node(1); 
		tree.root.left = new Node(2); 
		tree.root.right = new Node(3); 
		tree.root.left.left = new Node(4); 
		tree.root.left.right = new Node(5); 
		tree.root.right.left = new Node(6); 
		tree.root.right.right = new Node(7);  
 
		assertEquals("Test 1a LCA(4,5):", 2, tree.findLCA(4,5));
		assertEquals("Test 1b, Missing node", -1, tree.findLCA(4,9));   
		assertEquals("Test 1c, Missing node", -1, tree.findLCA(8,7)); 
		assertEquals("Test 1d LCA(8,9) missing Nodes", -1, tree.findLCA(8,9));
	}
	
	@Test
	public void test2() {
		LCA tree = new LCA(); 
		tree.root = new Node(1); 
		tree.root.left = new Node(2); 
		tree.root.left.left = new Node(3);  
		tree.root.left.left.left = new Node(4);
		tree.root.left.left.left.left= new Node(5); 

		assertEquals("Test 2a LCA(4,5)", 4, tree.findLCA(4,5));
		assertEquals("Test 2b missing node", -1, tree.findLCA(4, 6));
		assertEquals("Test 2c missing node", -1, tree.findLCA(8, 4));
		
	}
	
	@Test
	public void test3() {
		LCA tree = new LCA(); 
		tree.root = new Node(1); 
		tree.root.right = new Node(2); 
		tree.root.right.right = new Node(3);  
		tree.root.right.right.right = new Node(4);
		tree.root.right.right.right.right= new Node(5); 

		assertEquals("Test 3a LCA(4,5)", 4, tree.findLCA(4, 5));
		assertEquals("Test 3b missing node", -1, tree.findLCA(4, 6));
		assertEquals("Test 3c missing node", -1, tree.findLCA(8, 4));
	}
	
	@Test
	public void test4() {
		LCA tree = new LCA(); 
		tree.root = new Node(1); 
		tree.root.left = new Node(2); 
		tree.root.right = new Node(3); 
		tree.root.left.left = new Node(4); 
		tree.root.left.right = new Node(5); 
		tree.root.right.left = new Node(6); 
		tree.root.right.right = new Node(7); 
		tree.root.right.right.right = new Node(8);
		tree.root.right.right.left = new Node(9);
		tree.root.right.left.right = new Node(10);
		tree.root.right.left.left = new Node(11);
		tree.root.right.right.right.right = new Node(12);
		tree.root.left.left.left = new Node(13);

		assertEquals("Test 4a LCA(4,5)", 2, tree.findLCA(4, 5));
		assertEquals("Test 4b LCA(4, 11)", 1, tree.findLCA(4, 11));
		assertEquals("Test 4c LCA(12,7)", 7, tree.findLCA(12, 7));
		assertEquals("Test 4d LCA(13,9)", 1, tree.findLCA(13, 9));
		assertEquals("Test 4e LCA(5,13)", 2, tree.findLCA(5, 13));
	} 
	
	@Test
	public void test5() {
		DirectedAcyclicGraph tree = new DirectedAcyclicGraph(3); 
		
		assertEquals("Test 5a self-loop", false, tree.addEdge(0, 0));
		
		assertEquals("Test 5b add edge.", true, tree.addEdge(0, 1));
		assertEquals("Test 5c add edge.", true, tree.addEdge(1, 2));
		
		assertEquals("Test 5d edge that would cause cycle.", false, tree.addEdge(2, 0));
		
		assertEquals("Test 5e edge from non-existing vertices.", false, tree.addEdge(5, 4));
		assertEquals("Test 5f edge from non-existing vertices.", false, tree.addEdge(89, 53));
		assertEquals("Test 5g  edge from negative vertices.", false, tree.addEdge(-2, -4));
				
	}
	@Test
	public void test6(){
		DirectedAcyclicGraph tree = new DirectedAcyclicGraph(5);
		
		tree.addEdge(0, 1);
		tree.addEdge(0, 2);
		tree.addEdge(2, 3);
		tree.addEdge(3, 4);
		
		ArrayList<Integer> expectedResult = new ArrayList<Integer>();
		expectedResult.add(0);
				
		assertTrue("Testing 6a single lca return", tree.lowestCommonAncestor(4,1).size() == expectedResult.size());
		for(int i=0; i<expectedResult.size();i++){
			assertTrue("Testing 6a single lca return", tree.lowestCommonAncestor(4,1).contains(i));
		}
		

	}
	@Test
	public void test7(){
		DirectedAcyclicGraph tree = new DirectedAcyclicGraph(7);

		tree.addEdge(0, 3);			
		tree.addEdge(1, 3); 
		tree.addEdge(1, 4);
		tree.addEdge(2, 5);
		tree.addEdge(2, 6);
		tree.addEdge(3, 5);
		tree.addEdge(3, 6);
		tree.addEdge(4, 6);
		
		ArrayList<Integer> expectedResult = new ArrayList<Integer>();
		expectedResult.clear();
		expectedResult.add(2);
		expectedResult.add(3);
				
		assertTrue("Testing 7a mutliple lca return", tree.lowestCommonAncestor(5,6).size() == expectedResult.size());
		for(int i : expectedResult){
			assertTrue("Testing 7a mutliple lca return", tree.lowestCommonAncestor(5,6).contains(i));
		}
	}
	
	@Test
	public void test8(){
		DirectedAcyclicGraph tree = new DirectedAcyclicGraph(0);
		ArrayList<Integer> expectedResult = new ArrayList<Integer>();
		
		for(int i : expectedResult){
			assertFalse("Testing empty tree", tree.lowestCommonAncestor(5,6).contains(i));
		}
	}
	
	@Test
	public void test9() {
		LCA tree = new LCA(); 
		tree.root = new Node(1); 
		assertEquals("Test 9a, Missing node", -1, tree.findLCA(1,9));  
		tree.root.left = new Node(2); 
		assertEquals("Test 9b", 1, tree.findLCA(1,2));
		tree.root.right = new Node(3);
		assertEquals("Test 9c", 1, tree.findLCA(2,3));
	}
	
}
