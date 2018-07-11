/********Software Analysis - FY2013*************/
/*
* File Name: data_lost.c
* Defect Classification
* ---------------------
* Defect Type: Misc defects
* Defect Sub-type: Useless assignment
* Description: Defect Free Code to identify false positives during useless assignment
*/
#include "HeaderFile.h"
int rand (void);

/*
 * Types of defects: a pointless assignment
 * Complexity: a pointless assignment
 */
void insign_code_001 ()
{
	int i;
	int j;

	i = rand();
	j = i - 1;
	i = j - 1; /*Tool should not detect this line as error*/ /*No ERROR:Useless Assignment */
	printf("%d",i);
}

/*
 * Types of defects: a pointless assignment
 * pointless assignment main function
 */
void insign_code_main ()
{
	if (vflag > 0)
	{
		insign_code_001();
	}
}


int vflag;

int main(int argc,char*argv[])
{
  if(argv[1]) {
    vflag = atoi(argv[1]);
    insign_code_main();
    printf("Done (in main)\n");
  } else {
    printf("Enter Function XXX \n");
    printf("Example: To Execute All Functions ,Enter 888 \n");
  }
}
