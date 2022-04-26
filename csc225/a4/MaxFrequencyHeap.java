// Name: Yeil Park
// Student number: V00962281

public class MaxFrequencyHeap implements PriorityQueue {
	
	private static final int DEFAULT_CAPACITY = 10;
	private Entry[] data;
	private int size;
    private void heapifyUp(int i) {
    	int parent = (i - 1) / 2;
    	if(i != 0 && this.data[i].getFrequency() > this.data[parent].getFrequency()) {
    		Entry temp = this.data[i];
			this.data[i]=this.data[parent];
			this.data[parent]=temp;
    		heapifyUp(parent);
    	}
    }
	private void heapifyDown(int i) {
    	int largest = i;
    	int left = 2*i+1;
    	int right = 2*i+2;
    	if(left < size && this.data[left].getFrequency() > this.data[largest].getFrequency())
			largest = left;
	    if(right < size && this.data[right].getFrequency() > this.data[largest].getFrequency())
    		largest = right;
	    if(largest != i) {
	    	Entry temp = this.data[largest];
            this.data[largest]=this.data[i];
			this.data[i]=temp;
            heapifyDown(largest);
	    }
    }
	// init
	public MaxFrequencyHeap() {
		data = new Entry[DEFAULT_CAPACITY];
		size = 0;
	}
	// init with size
	public MaxFrequencyHeap(int size) {
		data = new Entry[size];
		size = 0;
	}
	public void insert(Entry element) {
        this.data[size]=element;
        this.size++;
        this.heapifyUp(size-1);
    }
	/*
	 * Purpose: remove Max frequency Entry and get that value
	 * Returns: TreeNode - removed Entry
	 */	
	public Entry removeMax() { 
    	if (this.isEmpty()) return null;
        Entry entryToRetrun = this.data[0];
		this.data[0]=this.data[size-1];
        this.size--;
        this.heapifyDown(0);
        return entryToRetrun;
	}
	
	public boolean isEmpty() {
		if (this.size==0) return true;
		return false; // so it compiles
	}
	
	public int size() {
		return this.size; // so it compiles
	}

}
 
