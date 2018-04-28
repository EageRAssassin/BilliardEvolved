build:
	ocamlbuild -use-ocamlfind \
		-plugin-tag "package(js_of_ocaml.ocamlbuild)" \
		-no-links \
		main.d.js
	ocamlbuild -use-ocamlfind types.cmo state.cmo ai.cmo gui.cmo game.cmo -r
clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind types.cmo state.cmo ai.cmo gui.cmo -r
	ocamlbuild -use-ocamlfind -pkg oUnit test_ai.cmo -r
