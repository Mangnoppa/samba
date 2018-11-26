CNAME=samba
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

all: clean $(CNAME)

$(CNAME):
	docker build -t $(CNAME):$(BRANCH) .

clean:
	docker stop $(CNAME) || true
	docker rm $(CNAME) || true
	docker rmi $(CNAME):$(BRANCH) || true
