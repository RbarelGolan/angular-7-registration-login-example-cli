# Presentation of POC for Angular to React Migration

## Introduction

This task was to test the use of Mirco-Frontends in an
Angular 7 application in order to replace existing
components with new React components.
The goal being to test the feasibility of migrating
gradually from Angular to React.

## Steps

In order for the Angular application to be able to use
Module Federation, the key component of Micro-Frontends,
we needed to upgrade the Webpack component to version 5
without upgrading the Angular version and without
breaking the Angular application.

1. Replace Angular CLI with Webpack 4
1. Upgrade Webpack 4 to Webpack 5
1. Add Module Federation Plugin to Webpack 5
1. Import an external component (React/Angular) into the
   Angular application

## Results

Steps 1-3 were successful and were relatively easy
despite our limited knowledge of the various technologies.

However we are still working on importing an existing
external component (Angular or
React) into the Angular application.

## Conclusion
[TBD]
