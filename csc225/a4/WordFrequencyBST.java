// Name: Yeil Park
// Student number: V00962281

public class WordFrequencyBST {
	private TreeNode root;
	private int numElements;
	
	public WordFrequencyBST() {
		root = null;
		numElements = 0;
	}
	
	/*
	 * Purpose: Update the BST by handling input word 
	 * Parameters: String word - The new word to handle
	 * Returns: Nothing
	 * Explanation: If there is no entry in the tree 
	 *   representing the word, then the a new entry 
	 *   should be created and placed into the correct 
	 *   location of the BST. Otherwise, the existing
	 *   entry for the word should have its frequency
	 *   value incremented. 
	 */	
	public void handleWord(String word) {
		
		root = addRecursive(this.root, word);

		// TODO: Complete this method
	}

	
	/*
	 * Purpose: Get the frequency value of the given word
	 * Parameters: String word - the word to find
	 * Returns: int - the word's associated frequency
	 */	
	public int getFrequency(String word) {
		int result = 0;
		TreeNode target = search(this.root,word);
		if(target==null){
			return 0;
		}
		result = target.getData().getFrequency();
		return result;
	}
	/*
	 * Purpose: find TreeNode that has same string of given word
	 * Parameters: String word - the word to find
	 * Parameters: TreeNode current - Node to be recursed
	 * Returns: TreeNode - TreeNode that has same string of given word
	 */	
	private TreeNode search(TreeNode current,String word){
		if (current == null){
            return current;
        }
		if(current.getData().getWord().equals(word)){
			return current;
		}
        if (current.compareTo(word)>0) {
            return search(current.left,word);
        }
        return search(current.right,word);
	}
	/*
	 * Purpose: insert Entry in BST in Alphabetical Order
	 * Parameters: String word - the word to insert
	 * Parameters: TreeNode current - Node to be recursed
	 * Returns: TreeNode - TreeNode that an Entry inserted
	 */	
    private TreeNode addRecursive(TreeNode current, String word) {
		Entry entry = new Entry(word);
        if (current == null){
			this.numElements++;
			TreeNode newTreeNode = new TreeNode(entry);
            return newTreeNode;
        }
		
        if(current.getData().getWord().equals(word)){
			current.addToFrequency();
		}
        if (current.compareTo(word)>0) {
            current.left = addRecursive(current.left, word);

        }
        if (current.compareTo(word)<0) {
            current.right = addRecursive(current.right, word);
        }
        return current;
    }




	/****************************************************
	* Helper functions for Insertion and Search testing *
	****************************************************/
	
	public String inOrder() {
		if (root == null) {
			return "empty";
		}
		return "{" + inOrderRecursive(root) + "}";
	}
	
	public String inOrderRecursive(TreeNode cur) {
		String result = "";
		if (cur.left != null) {
			result = inOrderRecursive(cur.left) + ",";
		} 
		result += cur.getData().getWord();
		if (cur.right != null) {
			result += "," + inOrderRecursive(cur.right);
		}
		return result;
	}
	
	public String preOrder() {
		if (root == null) {
			return "empty";
		}
		return "{" + preOrderRecursive(root) + "}";
	}
	
	public String preOrderRecursive(TreeNode cur) {
		String result = cur.getData().getWord();
		if (cur.left != null) {
			result += "," + preOrderRecursive(cur.left);
		} 
		if (cur.right != null) {
			result += "," + preOrderRecursive(cur.right);
		}
		return result;
	}
	
	/****************************************************
	* Helper functions to populate a Heap from this BST *
	****************************************************/
	
	public MaxFrequencyHeap createHeapFromTree() {
		MaxFrequencyHeap maxHeap = new MaxFrequencyHeap(numElements+1);
		addToHeap(maxHeap, root);
		return maxHeap;
	}
	
	public void addToHeap(MaxFrequencyHeap h, TreeNode n) {
		if (n != null) {
			addToHeap(h, n.left);
			h.insert(n.getData());
			addToHeap(h, n.right);
		}
	}		
}