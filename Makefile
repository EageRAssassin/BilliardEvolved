build:
	ocamlbuild -use-ocamlfind types.cmo ai.cmo billiards.cmo state.cmo player.cmo -r

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind types.cmo state.cmo ai.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind -pkg oUnit test_ai.cmo -r
