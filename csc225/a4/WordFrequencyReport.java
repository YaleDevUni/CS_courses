// Name: Yeil Park
// Student number: V00962281

public class WordFrequencyReport {
	private static final int CAPACITY = 5;
	
	/*
	 * Purpose: Obtain the 5 most frequent words found
	 * Parameters: MaxFrequencyHeap h - the heap containing all the word entry data
	 * Returns: Entry[] - an array containing the top 5 entries (which are the 
	 *     word, frequency pairs with the maximum frequency values)
	 */
	public static Entry[] overallMostFrequent(MaxFrequencyHeap h) {
		Entry[] top5 = new Entry[CAPACITY];
		if(h.size()<4){
			for(int i =0;i<h.size();i++){
				top5[i]=h.removeMax();
			}
		}else{
			top5[0]= h.removeMax();
			top5[1]= h.removeMax();
			top5[2]= h.removeMax();
			top5[3]= h.removeMax();
			top5[4]= h.removeMax();
		}

		
		return top5;
	}
	
	/*
	 * Purpose: Obtain the 5 most frequent words found that are at least n charaters long
	 * Parameters: MaxFrequencyHeap h - the heap containing all the word entry data
	 *             int n - minimum word length to consider
	 * Returns: Entry[] - an array containing the top 5 entries (which are the 
	 *     word, frequency pairs with the maximum frequency values of words 
	 *     that are at least n characters long)
	 */
	public static Entry[] atLeastLength(MaxFrequencyHeap h, int n) {
		Entry[] top5 = new Entry[CAPACITY];
		int cnt = 0;
		int itr = 0;
		while(cnt<CAPACITY&&itr<h.size()){
			Entry temp = h.removeMax();
			if(temp.getWord().length()>=n){
				
				top5[cnt]=temp;
				cnt++;
			}
			itr++;
		}
		// TODO: populate array

		return top5;
	}
	
	/*
	 * Purpose: Obtain the 5 most frequent words found that begin with the given letter
	 * Parameters: MaxFrequencyHeap h - the heap containing all the word entry data
	 *             char letter - only words that begin with given letter are considered
	 * Returns: Entry[] - an array containing the top 5 entries (which are the 
	 *     word, frequency pairs with the maximum frequency values of words 
	 *     that begin with the given letter)
	 */
	public static Entry[] startsWith(MaxFrequencyHeap h, char letter) {
		int size = h.size();
		Entry[] top5 = new Entry[CAPACITY];	
		int cnt = 0;
		int itr =0;
		while(cnt<CAPACITY&&itr<size){
			Entry temp = h.removeMax();
			if(temp.getWord().charAt(0)==letter){
				top5[cnt]=temp;
				cnt++;
			}
			itr++;
		}
		// TODO: populate array
		
		return top5;
	}
	
}
 
