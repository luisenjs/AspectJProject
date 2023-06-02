import java.io.File;
import java.io.FileWriter;
import java.util.Calendar;

public aspect Logger {
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    
    int hours =cal.get(Calendar.HOUR_OF_DAY);
    int minutes = cal.get(Calendar.MINUTE);
    int seconds = cal.get(Calendar.SECOND);
    
    pointcut transaction() : call(* moneyMake*(..));
    after() : transaction() {    	
    	System.out.println("** Transaction completed **");
    	
    	escribirArchivo("Transaction");

    }
    
	pointcut withdraw() : call(* moneyWithdrawal*(..));
    after() : withdraw() {    	
    	System.out.println("** Money withdrawn **");
    	
    	escribirArchivo("Money withdrawn");

    }
    
    
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("** User created **");

    }
    
    private void escribirArchivo(String typeTransaction) {
    	try {
    		FileWriter archivo = new FileWriter(file,true);
    		archivo.write(typeTransaction+" "+hours+":"+minutes+":"+seconds+"\n");
    		archivo.close();
    	} catch(Exception e) {
    		System.out.println("Error: "+e.getMessage());
    	}
    }

}
