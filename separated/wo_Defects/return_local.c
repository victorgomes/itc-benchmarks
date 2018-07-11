/********Software Analysis - FY2013*************/
/*
* File Name: return_local.c
* Defect Classification
* ---------------------
* Defect Type: Resource management defects
* Defect Sub-type: Return of a pointer to a local variable
* Description: Defect Free Code to identify false positives in return of local variables
*/

#include "HeaderFile.h"
/*
 * Types of defects: return back -local variables (area)
 * Complexity: return local variable as a function return value
 */
int* return_local_001_func_001 ()
{
	static int buf[5];
	return buf; /*Tool should not detect this line as error*/ /*No ERROR: return - pointer to local variable */
}

void return_local_001 ()
{
	int *p;
	p = return_local_001_func_001();
	p[3] = 1;
}

/*
 * Types of defects: return  - local variables (area)
 * Complexity: return local variable as function arguments
 */
void return_local_002_func_001 (int **pp)
{
	static int buf[5];
	*pp = buf; /*Tool should not detect this line as error*/ /*No ERROR: return - pointer to local variable */
}

void return_local_002 ()
{
	int *p;
	return_local_002_func_001(&p);
	p[3] = 1;
}

/*
 * Types of defects: return  - local variables (area)
 * return local variable main function
 */
void return_local_main ()
{
	if (vflag == 1 || vflag ==888)
	{
		return_local_001();
	}

	if (vflag == 2 || vflag ==888)
	{
		return_local_002();
	}
}


int vflag;

int main(int argc,char*argv[])
{
  if(argv[1]) {
    vflag = atoi(argv[1]);
    return_local_main();
    printf("Done (in main)\n");
  } else {
    printf("Enter Function XXX \n");
    printf("Example: To Execute All Functions ,Enter 888 \n");
  }
}
