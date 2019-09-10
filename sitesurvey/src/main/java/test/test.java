package test;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int a[] = {1,2,3,4,5,6,7,8,9};
		char b[] = {'A','B','C','D'};
        Random rand = new Random(); 

        for(int i = 100;i<322;i++)
        {
		int randnum = rand.nextInt(9);
		int randchar = rand.nextInt(3);

		System.out.println(b[randchar]+""+a[randnum]);
        }
	}
}
