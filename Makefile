all: 01.w_Defects.c 02.wo_Defects.c harness.native

01.w_Defects.c: 01.w_Defects/*.c
	./combineAll.sh 01.w_Defects

02.wo_Defects.c: 02.wo_Defects/*.c
	./combineAll.sh 02.wo_Defects

harness.native: harness.ml
	ocamlbuild harness.native -libs str,unix

.PHONY: clean
clean:
	rm -rf 01.w_Defects.c 02.wo_Defects.c harness.native _build cerb.prof