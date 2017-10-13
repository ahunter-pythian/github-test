#!/usr/bin/env groovy

import hudson.plugins.git.*
import hudson.model.*
import jenkins.model.*

def setPipelineDescription() {
    def currentVersion = getCurrentVersion()
    echo "The current version is ${currentVersion}"
    currentBuild.description = "${currentVersion}"
}

def getCurrentVersion() {
    def currentVersion = sh (script: 'awk -F\'"\' \'{print $2}\' dist/version.js', returnStdout: true).trim()
    return currentVersion
}

node {
    stage("Build") {
        setPipelineDescription()
    }
}
