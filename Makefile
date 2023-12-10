.PHONY: test check

game:
	OCAMLRUNPARAM=b dune exec bin/main.exe

build:
	dune build

doc:
	dune build @doc

opendoc: doc
	@bash opendoc.sh

utop:
	OCAMLRUNPARAM=b dune utop lib

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

bisect: bisect-clean
	-dune exec --instrument-with bisect_ppx --force test/main.exe
	bisect-ppx-report html

bisect-clean:
	rm -rf _coverage bisect*.coverage

clean: bisect-clean
	dune clean
	rm -f search.zip

zip:
	rm -f Project_0_Degrees.zip
	zip -r Project_0_Degrees.zip . -x@exclude.lst