#!/usr/bin/env bash

#echo "BASH_SOURCE: ${BASH_SOURCE[0]}"

if [ -z "${ORIGIN_DIR}" ]; then
	ORIGIN_DIR=$(pwd)
	BASH_SOURCE_ORIGIN="${BASH_SOURCE[0]}"
fi

if [ -z "${PROJECT_ROOT}" ]; then
	PROJECT_ROOT=$(dirname $(realpath "${BASH_SOURCE_ORIGIN}"))
	cd "${PROJECT_ROOT}" || exit 1
	PROJECT_ROOT=$(pwd)
fi

if [ "$(declare -p FUNCTIONS_INCLUDE 2>/dev/null)"  == '' ] || [ -z "${FUNCTIONS_INCLUDE[$(pwd)"/bashColours.sh"]}" ]; then
	. "${PROJECT_ROOT}/CLI/lib/bashColours.sh"
fi

case "$*" in
	*--verbose* | *-v*)
		info "Verbose"
		VERBOSE=1
		;;
	*--dry-run*)
		info "Dry run"
		DRY_RUN=1
		;;
	*--clear-cache*)
		rm -vfr node_modules
		npm cache clean --force
		;;
	*--clear-modules*)
		rm -vfr node_modules
		;;
	*--install*)
		INSTALL='true'
		;;
	*--start*)
		START='true'
		;;
	*) # unrecognized option - show help or ignore
		# warning "HOSTNAME not matched ()"
		;;
esac

DEPENDENCIES=''
#DEPENDENCIES+=' @angular/compiler@~7.0.4'
#DEPENDENCIES+=' @angular/animations@~7.0.0'
#DEPENDENCIES+=' @angular/common@~7.0.0'
#DEPENDENCIES+=' @angular/compiler@~7.0.0'
#DEPENDENCIES+=' @angular/core@~7.0.0'
#DEPENDENCIES+=' @angular/forms@~7.0.0'
#DEPENDENCIES+=' @angular/http@~7.0.0'
#DEPENDENCIES+=' @angular/platform-browser@~7.0.0'
#DEPENDENCIES+=' @angular/platform-browser-dynamic@~7.0.0'
#DEPENDENCIES+=' @angular/router@~7.0.0'
#DEPENDENCIES+=' core-js@~2.5.4'
#DEPENDENCIES+=' rxjs@~6.3.3'
#DEPENDENCIES+=' zone.js@~0.8.26'

DEV_DEPENDENCIES=''

#DEV_DEPENDENCIES+=' codelyzer@~4.5.0'
#DEV_DEPENDENCIES+=' @angular/compiler@7.2.16'
#DEV_DEPENDENCIES+=' @babel/core'
#DEV_DEPENDENCIES+=' @babel/preset-env'
#DEV_DEPENDENCIES+=' @babel/preset-typescript'
#DEV_DEPENDENCIES+=' @types/jasmine@~2.8.8'
DEV_DEPENDENCIES+=' @types/node@~8.9.4'
DEV_DEPENDENCIES+=' angular2-template-loader@~0.6.2'
#DEV_DEPENDENCIES+=' babel-loader'
#DEV_DEPENDENCIES+=' clean-webpack-plugin'
DEV_DEPENDENCIES+=' html-webpack-plugin@~4.5.2'
DEV_DEPENDENCIES+=' html-loader@~0.5.5'
#DEV_DEPENDENCIES+=' protractor@~5.4.0'
#DEV_DEPENDENCIES+=' raw-loader@~0.5.1'
DEV_DEPENDENCIES+=' ts-loader@~5.2.2'
DEV_DEPENDENCIES+=' ts-node@~7.0.0'
DEV_DEPENDENCIES+=' typescript@~3.1.1'
DEV_DEPENDENCIES+=' webpack@~4.23.1'
DEV_DEPENDENCIES+=' webpack-cli@~3.1.2'
DEV_DEPENDENCIES+=' webpack-dev-server@~3.1.10'

if [ -n "${DEPENDENCIES}" ]; then
	INSTALL_COMMAND="npm install --save ${DEPENDENCIES}"
	if [[ ${VERBOSE,,} =~ true|yes|1 ]] || [[ ${DRY_RUN,,} =~ true|yes|1 ]]; then
		codeOutput "${INSTALL_COMMAND}"
	fi
	if [[ ! ${DRY_RUN,,} =~ yes|y|true|1 ]]; then
		${INSTALL_COMMAND}
	fi
fi

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

if [[ ${CHECK,,} =~ true|yes|1 ]]; then
	npm ls
fi
if [[ ${INSTALL,,} =~ true|yes|1 ]]; then
	npm i
fi
if [[ ${START,,} =~ true|yes|1 ]]; then
	npm start
fi

if [ "${BASH_SOURCE_ORIGIN}" == "${BASH_SOURCE_REALPATH}" ]; then
	cd "${ORIGIN_DIR}" || error "Couldn't cd to ${ORIGIN_DIR} (202501161739591, ${BASH_SOURCE[0]})" 1
fi

exit
npm install --save-dev html-webpack-plugin@~3.2.0
npm install --save-dev angular2-template-loader@~0.6.2
npm install --save-dev protractor@~5.4.0
npm install --save-dev @types/jasmine@~2.8.8

npm uninstall @angular/animations @angular/http

npm uninstall @angular/cli
npm uninstall @angular-devkit/build-angular
npm uninstall @angular/language-service
npm uninstall @angular/compiler-cli

npm uninstall @angular/cli @angular-devkit/build-angular @angular/language-service @angular/compiler-cli

npm install --save-dev "@types/node@~10.12.0"
npm install --save-dev "angular2-template-loader@~0.6.2"
npm install --save-dev "html-webpack-plugin@~3.2.0"

npm install --save-dev "raw-loader@~0.5.1"
npm install --save-dev "ts-loader@~5.2.2"
npm install --save-dev "typescript@~3.1.3"
npm install --save-dev " html-loader@^0.5.5"

npm install --save-dev "webpack@4.23.1"
npm install --save-dev "webpack-cli@~3.1.2"
npm install --save-dev "webpack-dev-server@~3.1.10"

npm install --save-dev "angular2-template-loader@~0.6.2" "html-webpack-plugin@~3.2.0"
npm install --save-dev "webpack@4.23.1" "webpack-cli@~3.1.2" "webpack-dev-server@~3.1.10"

npm install --save-dev \
angular2-template-loader@^0.6.2 \
css-loader@^4.3.0 \
html-loader@^0.5.5 \
html-webpack-plugin@^4.5.2 \
style-loader@^1.2.1 \
ts-loader@^8.0.0 \
typescript@~4.0.0 \
webpack@^4.44.2 \
webpack-cli@^3.3.12 \
webpack-dev-server@^3.11.0

npm install --save-dev \
typescript@~4.0.0

npm uninstall \
@types/jasmine \
@types/jasminewd2 \
jasmine-core \
jasmine-spec-reporter \
protractor \
karma \
karma-chrome-launcher \
karma-coverage-istanbul-reporter \
karma-jasmine \
karma-jasmine-html-reporter
