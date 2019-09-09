package test;

import java.util.ArrayList;
import java.util.List;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
ArrayList<Integer> list = new ArrayList<Integer>();
list.add(73);
list.add(67);
list.add(38);
list.add(33);
System.out.println(gradingStudents(list));

	}
	static int roundUp(int n) {
	    return (n + 4) / 5 * 5;
	}

    public static List<Integer> gradingStudents(List<Integer> grades) {
    // Write your code here
          ArrayList<Integer> list = new ArrayList<Integer>();
    for(int i=0;i<grades.size();i++)
    {
        if(grades.get(i)<=35){
            list.add(grades.get(i));
        }
        else
        {
            int temp = roundUp(grades.get(i))-grades.get(i);
            if(temp<3){
 list.add(roundUp(grades.get(i)));
            }
            else
            {
                list.add(grades.get(i)); 
            }
       
        }
    }
     
         
      

      return list;
    

}
}
