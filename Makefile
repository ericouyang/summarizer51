all: Summarizer51.ml
	corebuild -lib str Summarizer51.native

clean:
	rm -rf _build Summarizer51.native
