build:
	ocamlbuild -use-ocamlfind \
		-plugin-tag "package(js_of_ocaml.ocamlbuild)" \
		-no-links \
		main.d.js
	ocamlbuild -use-ocamlfind types.cmo state.cmo command.cmo billiards.cmo gui.cmo game.cmo -r

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind types.cmo state.cmo command.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind -pkg oUnit test_ai.cmo -r
	ocamlbuild -use-ocamlfind test_ai.byte && ./test_ai.byte
