include .env
export

service:
	gh repo create $(SERVICE) --template RafaelRodriguezSanz/DevOps-starter-kit-service --private
	git submodule add -f https://github.com/$(GITHUB_USERNAME)/$(SERVICE) ./$(SERVICE)
	git add .gitmodules ./$(SERVICE)
	@timeout /t 1 /nobreak > nul
	git add .gitmodules
	git commit -m "Add: submodule $(SERVICE)"
	git submodule update --init --recursive

delete:
	gh repo delete $(SERVICE) --yes
	git config -f .gitmodules --remove-section submodule.$(SERVICE)
	git add .gitmodules
	git rm --cached ./$(SERVICE)
	docker run --rm --name tmp -v .:/workdir alpine sh -c "rm -rf /workdir/$(SERVICE) && rm -rf /workdir/.git/modules/$(SERVICE)"
	git commit -m "Remove: submodule $(SERVICE)"
	git submodule status