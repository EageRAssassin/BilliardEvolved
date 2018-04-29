build:
	ocamlbuild -use-ocamlfind types.cmo ai.cmo billiards.cmo -r

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind helper.cmo types.cmo state.cmo ai.cmo command.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind -pkg oUnit test_state.cmo test_ai.cmo test_command.cmo -r
	ocamlbuild -use-ocamlfind test_state.byte && ./test_state.byte
