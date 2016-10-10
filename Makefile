CUSTOM_INSTALL_FILEPATH=./custom_install.sh

help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

all: _start _general _bash _vim _i3 _mail execute clean

general: _start _general execute clean

bash: _start _bash execute clean

vim: _start _vim execute clean

i3: _start _i3 execute clean

mail: _start _mail execute clean

_start:
	cat install_scripts/start.sh >> $(CUSTOM_INSTALL_FILEPATH)

_general:
	cat install_scripts/general.sh >> $(CUSTOM_INSTALL_FILEPATH)

_bash:
	cat install_scripts/bash.sh >> $(CUSTOM_INSTALL_FILEPATH)

_vim:
	cat install_scripts/vim.sh >> $(CUSTOM_INSTALL_FILEPATH)

_i3:
	cat install_scripts/i3.sh >> $(CUSTOM_INSTALL_FILEPATH)

_mail:
	cat install_scripts/mail.sh >> $(CUSTOM_INSTALL_FILEPATH)

execute:
	cat install_scripts/main.sh >> $(CUSTOM_INSTALL_FILEPATH)
	chmod +x $(CUSTOM_INSTALL_FILEPATH)
	$(CUSTOM_INSTALL_FILEPATH)

clean:
	rm $(CUSTOM_INSTALL_FILEPATH)


