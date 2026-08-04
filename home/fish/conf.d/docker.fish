function docker_clear_all_containers
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
end
