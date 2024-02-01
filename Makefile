publish: build
	wrangler pages publish --project-name opszero-docs ./_build/html/

build: deps
	rm -rf _build/
	jupyter-book build --all .

deps:
	pip install -r ./requirements.txt
