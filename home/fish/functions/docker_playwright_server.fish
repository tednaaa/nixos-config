function docker_playwright_server
	docker run -p 3000:3000 --rm --init -it \
		--workdir "/home/$(whoami)" \
		--user "$(id -u):$(id -g)" \
		mcr.microsoft.com/playwright:v1.57.0-noble \
		/bin/sh -c "npx -y playwright@1.57.0 run-server --port 3000 --host 0.0.0.0"
end
