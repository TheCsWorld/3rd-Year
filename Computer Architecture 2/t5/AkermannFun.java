
public class AkermannFun {
	
	public static int procedureCalls = 0;
	public static int regWinDepth = 0;
	public static int maxRegWinDepth = 0;
	public static int overflows = 0;
	public static int underflows = 0;
	public static int regSlots = 0;
	public static int numOfRegSets = 6;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//numOfRegSets = 6;
		double time = 0.0;
		double startTime =0.0;
    	double endTime = 0.0;
    	
    	startTime = System.nanoTime();	
		ackermann(3,6);
		endTime = System.nanoTime();
		time = (endTime - startTime)/1000000;

		System.out.println("6 Register Sets:\n" + time);
		System.out.println("P Calls " + procedureCalls);
		System.out.println("U " + underflows);
		System.out.println("O " + overflows);
		System.out.println("MaxW " + maxRegWinDepth);
		
//		numOfRegSets = 8;
//		System.out.println("8 Register Sets:\n"  + getTime());
//		System.out.println(procedureCalls);
//		System.out.println(underflows);
//		System.out.println(overflows);
//		System.out.println(maxRegWinDepth);	
		
//		numOfRegSets = 16;
//		System.out.println("16 Register Sets:\n" + getTime());
//		System.out.println(procedureCalls);
//		System.out.println(underflows);
//		System.out.println(overflows);
//		System.out.println(maxRegWinDepth);

	}
	
	public static int  ackermann(int x, int y) {
		procedureCalls++;
		regWinDepth++;
		checkOverflow();
		int result = 0;
		if (x == 0) {
			regWinDepth--;
			checkUnderflow();
			return y+1;
		}
		else if (y == 0) {
			
			result = ackermann(x-1, 1);
			regWinDepth--;
			checkUnderflow();
			return result;
		} 
		else {
			
			result = ackermann(x-1, ackermann(x, y-1));
			regWinDepth--;
			checkUnderflow();
			return result;
		}
	}
	
	public static void checkOverflow() {
		if(regWinDepth>maxRegWinDepth){
			maxRegWinDepth = regWinDepth;
		}
		if(regSlots<numOfRegSets) {
			regSlots++;
		}
		else {
			overflows++;
		}
		
	}
	
	public static void checkUnderflow() {
		if(regSlots>2) {
			regSlots--;
		}
		else {
			underflows++;
		}
	}


}
