[![License](https://img.shields.io/github/license/plantec/Toplo.svg)](./LICENSE)
[![main Tests](https://github.com/plantec/Toplo/actions/workflows/Tests.yml/badge.svg?branch=main)](https://github.com/plantec/Toplo/actions/workflows/Tests.yml)

# Toplo
![toplo](https://github.com/plantec/Toplo/assets/49183340/57963fee-ed86-4ee0-99e1-7c39e9a9cdf9)

Toplo is a widget framework on top of Bloc. 

## Installation

To install the latest version of Toplo in Pharo you just need to execute the following script:

```Smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
    [ Metacello new baseline: 'Toplo'; repository: 'github://plantec/Toplo:SteelSheet/src';
        onConflictUseIncoming;
        ignoreImage;
        load.
    ] on: MCMergeOrLoadWarning do: [ :warning | warning load ].
  ].
].
```

To add in your project BaselineOf:

```Smalltalk
spec baseline: 'Toplo' with: [ spec repository: 'github://plantec/Toplo:SteelSheet/src' ].
```

## Look and Feel features (work in progress)

A look and feel management is currently in development, using modern styles and skin management.

![image](https://github.com/plantec/Toplo/assets/49183340/2e61623f-5844-4294-b87a-195dd6c1c636)
![image](https://github.com/plantec/Toplo/assets/49183340/a76ee5a2-1e2f-414f-8ab8-4dad71d4fc4f)
