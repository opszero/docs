build: download
	rm -rf _build/
	jupyter-book build .
	aws --profile opszero s3 sync --acl public-read --delete ./_build/html s3://docs.opszero.com

download:
	gh api /repos/opszero/template-infra/contents/README.md | jq -r '.content' | base64 -d > infra-as-code/template-infra.md
	gh api /repos/opszero/terraform-aws-mrmgr/contents/README.md | jq -r '.content' | base64 -d > cloud/terraform-aws-mrmgr.md
	gh api /repos/opszero/terraform-helm-kubespot/contents/README.md | jq -r '.content' | base64 -d  > kubernetes/terraform-helm-kubespot.md
	gh api /repos/opszero/terraform-aws-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-aws-kubespot.md
	gh api /repos/opszero/terraform-google-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-google-kubespot.md
	gh api /repos/opszero/terraform-azurerm-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-azurerm-kubespot.md

requirements:
	pip3 install -r ./requirements.txt
