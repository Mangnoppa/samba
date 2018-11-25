CNAME=samba

all: clean $(CNAME)

$(CNAME):
	docker build -t $(CNAME) .

clean:
	docker stop $(CNAME) || true
	docker rm $(CNAME) || true
	docker rmi $(CNAME) || true
