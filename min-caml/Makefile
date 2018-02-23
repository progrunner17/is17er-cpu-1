INLINE = 80
min-caml: lexer.mll parser.mly float.c \
		h.mli h.ml id.mli id.ml type.mli type.ml m.mli m.ml s.mli s.ml \
		syntax.mli syntax.ml typing.mli typing.ml kNormal.mli kNormal.ml \
		alpha.mli alpha.ml beta.mli beta.ml assoc.mli assoc.ml \
		inline.mli inline.ml constFold.mli constFold.ml elim.mli elim.ml cse.mli cse.ml \
		closure.mli closure.ml asm.mli asm.ml virtual.mli virtual.ml \
		simm.mli simm.ml regAlloc.mli regAlloc.ml emit.mli emit.ml \
		main.mli main.ml
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlopt.opt -cc "gcc" -ccopt "-g -O2 -Wall -o float.o" float.c
	ocamlopt.opt -o min-caml str.cmxa \
		float.o h.mli h.ml id.mli id.ml type.mli type.ml m.mli m.ml s.mli s.ml \
		syntax.mli syntax.ml parser.mli parser.ml lexer.ml typing.mli typing.ml kNormal.mli kNormal.ml \
		alpha.mli alpha.ml beta.mli beta.ml assoc.mli assoc.ml \
		inline.mli inline.ml constFold.mli constFold.ml elim.mli elim.ml cse.mli cse.ml \
		closure.mli closure.ml asm.mli asm.ml virtual.mli virtual.ml \
		simm.mli simm.ml regAlloc.mli regAlloc.ml emit.mli emit.ml \
		main.mli main.ml

raytracer/min-rt.s: min-caml raytracer/min-rt.ml raytracer/globals.ml
	./min-caml raytracer/min-rt -globals raytracer/globals -inline $(INLINE)
min-rt:
	make raytracer/min-rt.s

clean:
	rm -f *.cmi *.cmo *.cmx *.o parser.mli parser.ml lexer.mli lexer.ml min-caml \
		test/*.s raytracer/*.s raytracer/min-rt-globals.ml
