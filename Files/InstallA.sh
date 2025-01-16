#!/usr/bin/env bash

#echo "BASH_SOURCE: ${BASH_SOURCE[0]}"

if [ -z "${ORIGIN_DIR}" ]; then
	ORIGIN_DIR=$(pwd)
	BASH_SOURCE_ORIGIN="${BASH_SOURCE[0]}"
fi

if [ -z "${PROJECT_ROOT}" ]; then
	CUTOFF='Files'
	BASH_SOURCE_REALPATH=$(realpath "${BASH_SOURCE_ORIGIN}")
	PROJECT_ROOT="${BASH_SOURCE_REALPATH%${CUTOFF}*}"
	PROJECT_ROOT="${PROJECT_ROOT%\/}"
	if [ -z "${PROJECT_ROOT}" ] && [ ! -f "$(pwd)/${BASH_SOURCE_REALPATH}" ]; then
		echo "Failed to detect root (202501161527051, ${BASH_SOURCE[0]})"
		exit 1
	fi
	cd "${PROJECT_ROOT}" || exit 1
	PROJECT_ROOT=$(pwd)
fi

if [ "$(declare -p FUNCTIONS_INCLUDE 2>/dev/null)"  == '' ] || [ -z "${FUNCTIONS_INCLUDE[$(pwd)"/bashColours.sh"]}" ]; then
	. "${PROJECT_ROOT}/CLI/lib/bashColours.sh"
fi

pwd

DEV_DEPENDENCIES=''
DEV_DEPENDENCIES+=' angular2-template-loader@~0.6.2'
DEV_DEPENDENCIES+=' html-webpack-plugin@~3.2.0'
DEV_DEPENDENCIES+=' raw-loader@~0.5.1'
DEV_DEPENDENCIES+=' ts-loader@~5.4.5'
DEV_DEPENDENCIES+=' @types/node@~8.9.4'
DEV_DEPENDENCIES+=' webpack-cli@~3.1.2'
DEV_DEPENDENCIES+=' webpack-dev-server@~3.1.10'
DEV_DEPENDENCIES+=' webpack@~4.23.1'

if [ -n "${DEV_DEPENDENCIES}" ]; then
	INSTALL_DEV_COMMAND="npm install --save-dev ${DEV_DEPENDENCIES}"
	if [[ ${VERBOSE,,} =~ true|yes|1 ]] || [[ ${DRY_RUN,,} =~ true|yes|1 ]]; then
		codeOutput "${INSTALL_DEV_COMMAND}"
	fi
	if [[ ! ${DRY_RUN,,} =~ yes|y|true|1 ]]; then
		${INSTALL_DEV_COMMAND}
	fi
fi

UNINSTALL=''
UNINSTALL+=' @angular/cli'
UNINSTALL+=' @angular-devkit/build-angular'
UNINSTALL+=' @angular/language-service'
UNINSTALL+=' @angular/compiler-cli'

if [ -n "${UNINSTALL}" ]; then
	UNINSTALL_COMMAND="npm uninstall ${UNINSTALL}"
	if [[ ${VERBOSE,,} =~ true|yes|1 ]] || [[ ${DRY_RUN,,} =~ true|yes|1 ]]; then
		codeOutput "${UNINSTALL_COMMAND}"
	fi
	if [[ ! ${DRY_RUN,,} =~ yes|y|true|1 ]]; then
		${UNINSTALL_COMMAND}
	fi
fi

if [ "${BASH_SOURCE_ORIGIN}" == "${BASH_SOURCE_REALPATH}" ]; then
	cd "${ORIGIN_DIR}" || error "Couldn't cd to ${ORIGIN_DIR} (202501161740101, ${BASH_SOURCE[0]})" 1
fi

exit

#npm uninstall webpack-cli
#npm install --save-dev webpack-cli@3
#npm install --save-dev webpack-dev-server@3

#npm uninstall html-webpack-plugin
#npm install --save-dev html-webpack-plugin@4
#npm install --save-dev webpack@4 webpack-cli@3

#npm uninstall ts-loader
#npm install --save-dev ts-loader@5

npm start
#npm install --save-dev webpack@4 webpack-cli@3
#npm install --save-dev ts-loader html-webpack-plugin clean-webpack-plugin
#npm uninstall @angular/cli
