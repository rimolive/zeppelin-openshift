LOCAL_IMAGE ?= zeppelin-openshift

DOCKERFILE_CONTEXT=zeppelin-build

.PHONY: build push clean clean-context context zero-tarballs

build: $(DOCKERFILE_CONTEXT)
	docker build --pull -t $(LOCAL_IMAGE) $(DOCKERFILE_CONTEXT)

push: build
	docker tag $(LOCAL_IMAGE) $(PUSH_IMAGE)
	docker push $(PUSH_IMAGE)

clean: clean-context
	-docker rmi $(LOCAL_IMAGE) $(PUSH_IMAGE)

clean-context:
	-rm -rf target
	-rm -rf $(DOCKERFILE_CONTEXT)/*

context: $(DOCKERFILE_CONTEXT)

$(DOCKERFILE_CONTEXT): $(DOCKERFILE_CONTEXT)/Dockerfile $(DOCKERFILE_CONTEXT)/modules

$(DOCKERFILE_CONTEXT)/Dockerfile $(DOCKERFILE_CONTEXT)/scripts:
	concreate generate --descriptor image.yaml
	cp -R target/image/* $(DOCKERFILE_CONTEXT)

zero-tarballs:
	find ./$(DOCKERFILE_CONTEXT) -name "*.tar.gz" -type f -exec truncate -s 0 {} \;
	find ./$(DOCKERFILE_CONTEXT) -name "*.tgz" -type f -exec truncate -s 0 {} \;