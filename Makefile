all: 01.w_Defects.c 02.wo_Defects.c

01.w_Defects.c: 01.w_Defects/*.c
	./combineAll.sh 01.w_Defects

02.wo_Defects.c: 02.wo_Defects/*.c
	./combineAll.sh 02.wo_Defects

.PHONY: clean
clean:
	rm -rf 01.w_Defects.c 02.wo_Defects.c