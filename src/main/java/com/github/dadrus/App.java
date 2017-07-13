package com.github.dadrus;

/**
 * Hello world App
 *
 */
public class App 
{
	public static final String PASSWORD="foo";
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
    }
	
	public void test() throws Exception {
		if(true) { // sonar doesn't like this comment style
			throw new Exception("this"); // and the raw exception anyway
		} else {
			throw new Exception("that");
		}
	}
}
