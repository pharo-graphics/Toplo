[![License](https://img.shields.io/github/license/pharo-graphics/Toplo.svg)](./LICENSE)
![toplo](https://github.com/pharo-graphics/Toplo/assets/49183340/57963fee-ed86-4ee0-99e1-7c39e9a9cdf9)

# Toplo

Toplo is a widget framework on top of Bloc. 

## Installation

Install the stable version of Toplo in current stable Pharo with:

```Smalltalk
EpMonitor disableDuring: [
  Author useAuthor: 'Load' during: [
    [ Metacello new baseline: 'Toplo'; repository: 'github://pharo-graphics/Toplo:master/src';
        onConflictUseIncoming;
        ignoreImage;
        load.
    ] on: MCMergeOrLoadWarning do: [ :warning | warning load ].
  ].
]
```

Add Toplo to your project Baseline with:

```Smalltalk
spec baseline: 'Toplo' with: [ spec repository: 'github://pharo-graphics/Toplo:master/src' ].
```

Replace `master` with `dev` to work on the branch for development.


## Look and Feel features (work in progress)

A look and feel management is currently in development, using modern styles and skin management.

![image](https://github.com/pharo-graphics/Toplo/assets/49183340/2e61623f-5844-4294-b87a-195dd6c1c636)
![image](https://github.com/pharo-graphics/Toplo/assets/49183340/a76ee5a2-1e2f-414f-8ab8-4dad71d4fc4f)


## License

This code is licensed under the [MIT license](./LICENSE).
