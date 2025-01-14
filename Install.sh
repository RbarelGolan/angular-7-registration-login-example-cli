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
	*) # unrecognized option - show help or ignore
		# warning "HOSTNAME not matched ()"
		;;
esac

DEPENDENCIES=''
DEPENDENCIES+=' @angular/compiler@~7.0.4'
DEPENDENCIES+=' @angular/animations@~7.0.0'
DEPENDENCIES+=' @angular/common@~7.0.0'
DEPENDENCIES+=' @angular/compiler@~7.0.0'
DEPENDENCIES+=' @angular/core@~7.0.0'
DEPENDENCIES+=' @angular/forms@~7.0.0'
DEPENDENCIES+=' @angular/http@~7.0.0'
DEPENDENCIES+=' @angular/platform-browser@~7.0.0'
DEPENDENCIES+=' @angular/platform-browser-dynamic@~7.0.0'
DEPENDENCIES+=' @angular/router@~7.0.0'
DEPENDENCIES+=' core-js@~2.5.4'
DEPENDENCIES+=' rxjs@~6.3.3'
DEPENDENCIES+=' zone.js@~0.8.26'


DEV_DEPENDENCIES=''

#DEV_DEPENDENCIES+=' angular2-template-loader@~0.6.2'
#DEV_DEPENDENCIES+=' codelyzer@~4.5.0'
#DEV_DEPENDENCIES+=' html-webpack-plugin@~3.2.0'
#DEV_DEPENDENCIES+=' protractor@~5.4.0'
#DEV_DEPENDENCIES+=' raw-loader@~0.5.1'
#DEV_DEPENDENCIES+=' ts-loader@~5.2.2'
#DEV_DEPENDENCIES+=' webpack-cli@~3.1.2'
#DEV_DEPENDENCIES+=' webpack-dev-server@~3.1.10'
#DEV_DEPENDENCIES+=' webpack@~4.23.1'
#DEV_DEPENDENCIES+=' @angular/compiler@7.2.16'
#DEV_DEPENDENCIES+=' npm install --save-dev'

DEV_DEPENDENCIES+=' @angular-devkit/build-angular@~0.13.3'
DEV_DEPENDENCIES+=' @angular/cli@~7.0.3'
DEV_DEPENDENCIES+=' @angular/compiler-cli@~7.2.6'
DEV_DEPENDENCIES+=' @angular/language-service@~7.0.0'
DEV_DEPENDENCIES+=' @types/jasmine@~2.8.8'
DEV_DEPENDENCIES+=' @types/jasminewd2@~2.0.3'
DEV_DEPENDENCIES+=' @types/node@~8.9.4'
DEV_DEPENDENCIES+=' codelyzer@~4.5.0'
DEV_DEPENDENCIES+=' jasmine-core@~2.99.1'
DEV_DEPENDENCIES+=' jasmine-spec-reporter@~4.2.1'
DEV_DEPENDENCIES+=' karma@~3.0.0'
DEV_DEPENDENCIES+=' karma-chrome-launcher@~2.2.0'
DEV_DEPENDENCIES+=' karma-coverage-istanbul-reporter@~2.0.1'
DEV_DEPENDENCIES+=' karma-jasmine@~1.1.2'
DEV_DEPENDENCIES+=' karma-jasmine-html-reporter@~0.2.2'
DEV_DEPENDENCIES+=' protractor@~5.4.0'
DEV_DEPENDENCIES+=' ts-node@~7.0.0'
DEV_DEPENDENCIES+=' tslint@~5.11.0'
DEV_DEPENDENCIES+=' typescript@~3.1.1'

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

if [ -z "${UNINSTALL}" ]; then
	npm uninstall ${UNINSTALL}
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


npm install --save-dev @angular/compiler@~7.2.16
npm install --save @angular/compiler@~7.0.0
