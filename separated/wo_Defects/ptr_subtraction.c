/********Software Analysis - FY2013*************/
/*
* File Name: ptr_subtraction.c
* Defect Classification
* ---------------------
* Defect Type: Pointer related defects
* Defect Sub-type: Incorrect pointer arithmetic
* Description: Defect Free Code to identify false positives in pointer arithmetic subtraction
*/

#include "HeaderFile.h"

/*
 * Types of defects: an incorrect pointer arithmetic
 * Complexity: an incorrect pointer arithmetic
 */
void ptr_subtraction_001 ()
{
    int buf1[10];
	int *buf2 = buf1 + 5;
	intptr_t offset;
	offset = buf1 - buf2; /*Tool should not detect this line as error*/ /*No ERROR:Incorrect pointer arithmetic*/
        sink = offset;
}

/*
 * Types of defects: an incorrect pointer arithmetic
 * Complexity: an incorrect pointer arithmetic
 */
void ptr_subtraction_002 ()
{
	int x= 10;
	int *ptr = &x;
	int *buf = (ptr);
	*buf = 20; /*Tool should not detect this line as error*/ /*No ERROR:Incorrect pointer arithmetic*/
}

/*
 * Types of defects: an incorrect pointer arithmetic
 * Complexity: volatile
 */
void ptr_subtraction_main ()
{
	if (vflag ==1 || vflag ==888)
	{
		ptr_subtraction_001();
	}

	if (vflag ==2 || vflag ==888)
	{
		ptr_subtraction_002();
	}

}


int vflag;

int main(int argc,char*argv[])
{
  if(argv[1]) {
    vflag = atoi(argv[1]);
    ptr_subtraction_main();
    printf("Done (in main)\n");
  } else {
    printf("Enter Function XXX \n");
    printf("Example: To Execute All Functions ,Enter 888 \n");
  }
}
