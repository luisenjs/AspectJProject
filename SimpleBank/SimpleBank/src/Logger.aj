import java.io.File;
import java.io.FileWriter;
import java.util.Calendar;

public aspect Logger {
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    
    int day = cal.get(Calendar.DATE);
    int month = cal.get(Calendar.MONTH);
    int year = cal.get(Calendar.YEAR);
    
    pointcut transaction() : call(* moneyMake*(..));
    after() : transaction() {    	
    	System.out.println("** Transaction completed **");
    	
    	try {
    		FileWriter archivo = new FileWriter(file, true);
    		archivo.write("Transaction "+day+"/"+month+"/"+year+"\n");
    		archivo.close();
    	}catch(Exception e) {
    		System.out.println("Error "+e.getMessage());
    	}

    }
    
	pointcut withdraw() : call(* moneyWithdrawal*(..));
    after() : withdraw() {    	
    	System.out.println("** Money withdrawn **");
    	
    	try {
    		FileWriter archivo = new FileWriter(file, true);
    		archivo.write("Money withdrawn "+day+"/"+month+"/"+year+"\n");
    		archivo.close();
    	}catch(Exception e) {
    		System.out.println("Error "+e.getMessage());
    	}

    }
    
    
    pointcut success() : call(* create*(..) );
    after() : success() {
    	System.out.println("** User created **");

    }

}
