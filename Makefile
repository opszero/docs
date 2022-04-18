build:
	rm -rf _build/
	jupyter-book build .
	aws --profile opszero s3 sync --acl public-read --delete ./_build/html s3://docs.opszero.com
