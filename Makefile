build: download
	rm -rf _build/
	jupyter-book build .
	aws --profile opszero s3 sync --acl public-read --delete ./_build/html s3://docs.opszero.com

download:
	gh api /repos/opszero/template-infra/contents/README.md | jq -r '.content' | base64 -d > infra-as-code/template.md

requirements:
	pip3 install -r ./requirements.txt
