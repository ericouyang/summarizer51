all: Summarizer51.ml
	corebuild Summarizer51.native

clean:
	rm -rf _build Summarizer51.native
