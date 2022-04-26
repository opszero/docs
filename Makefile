release:
	rm -rf _build/
	$(MAKE) download
	$(MAKE) build
	$(MAKE) upload

upload:
	aws --profile opszero s3 sync --acl public-read --delete ./_build/html s3://docs.opszero.com

build:
	jupyter-book build .

download:
	gh api /repos/opszero/template-infra/contents/README.md | jq -r '.content' | base64 -d > infra-as-code/template-infra.md
	gh api /repos/opszero/template-helm-rails/contents/README.md | jq -r '.content' | base64 -d > fullstack/template-helm-rails.md
	gh api /repos/opszero/template-helm-django/contents/README.md | jq -r '.content' | base64 -d > fullstack/template-helm-django.md
	gh api /repos/opszero/terraform-aws-mrmgr/contents/README.md | jq -r '.content' | base64 -d > cloud/terraform-aws-mrmgr.md
	gh api /repos/opszero/kubespot-linux/contents/README.md | jq -r '.content' | base64 -d  > kubernetes/kubespot-linux.md
	gh api /repos/opszero/terraform-helm-kubespot/contents/README.md | jq -r '.content' | base64 -d  > kubernetes/terraform-helm-kubespot.md
	gh api /repos/opszero/terraform-aws-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-aws-kubespot.md
	gh api /repos/opszero/terraform-google-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-google-kubespot.md
	gh api /repos/opszero/terraform-azurerm-kubespot/contents/README.md | jq -r '.content' | base64 -d > kubernetes/terraform-azurerm-kubespot.md
	gh api /repos/opszero/template-aws-lambda-python/contents/README.md | jq -r '.content' | base64 -d > serverless/template-aws-lambda-python.md
	gh api /repos/opszero/template-aws-lambda-go/contents/README.md | jq -r '.content' | base64 -d > serverless/template-aws-lambda-go.md
	gh api /repos/opszero/template-aws-lambda-rust/contents/README.md | jq -r '.content' | base64 -d > serverless/template-aws-lambda-rust.md
	gh api /repos/opszero/deploytag/contents/README.md | jq -r '.content' | base64 -d > cicd/deploytag.md
	gh api /repos/opszero/terraform-aws-bastion/contents/README.md | jq -r '.content' | base64 -d > compliance/terraform-aws-bastion.md
	gh api /repos/opszero/terraform-aws-elb-cloudwatch/contents/README.md | jq -r '.content' | base64 -d > compliance/terraform-aws-elb-cloudwatch.md

requirements:
	pip3 install -r ./requirements.txt
