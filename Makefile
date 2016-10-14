CUSTOM_INSTALL_FILEPATH=./custom_install.sh

# This variable has to be set in install_scripts/main.sh too
CUSTOM_HOME_FILEPATH=./custom_home_path

help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

all: _start _general _bash _vim _i3 _mail execute clean

general: _start _general execute clean

bash: _start _bash execute clean

vim: _start _vim execute clean

i3: _start _i3 execute clean

mail: _start _mail execute clean

sethome:
	echo "What do you want to set as home folder"
	cat > $(CUSTOM_HOME_FILEPATH)

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
	rm -f $(CUSTOM_INSTALL_FILEPATH) $(cUSTOM_HOME_FILEPATH)


