
start:
	docker run -d -eUSER_NAME=student -eUSER_PASSWORD=password -ePASSWORD_ACCESS=true -p2222:2222 linuxserver/openssh-server > cont_id.txt

stop:
	echo $$(cat cont_id.txt)
	docker stop $$(cat cont_id.txt)
	docker rm $$(cat cont_id.txt)
	rm cont_id.txt