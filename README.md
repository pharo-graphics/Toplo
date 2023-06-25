# Toplo
![toplo](https://github.com/plantec/Toplo/assets/49183340/57963fee-ed86-4ee0-99e1-7c39e9a9cdf9)

A widget framework on top of Bloc.

[![Pharo 11 CI](https://github.com/plantec/Toplo/actions/workflows/Pharo11CI.yml/badge.svg?branch=master)](https://github.com/plantec/Toplo/actions/workflows/Pharo11CI.yml)

## Installation

```Smalltalk
Metacello new
	baseline: 'Toplo';
	repository: 'github://plantec/Toplo/src';
	onConflictUseIncoming;
	load
```

# Toplo Look and Feel & Theme

![image](https://github.com/plantec/Toplo/assets/49183340/2e61623f-5844-4294-b87a-195dd6c1c636)

![image](https://github.com/plantec/Toplo/assets/49183340/a76ee5a2-1e2f-414f-8ab8-4dad71d4fc4f)

A look and feel management is currently in development in a dedicated branch : dev-lookandfeel.

The evolutions from master branch are regularly integrated into this development branch.

This branch contains some examples to use the default Toplot look and feel inspired by [Ant Design](https://github.com/ant-design/ant-design) or create your own themes and skins.

[![Pharo 11 CI](https://github.com/plantec/Toplo/actions/workflows/Pharo11CI.yml/badge.svg?branch=dev-lookandfeel)](https://github.com/plantec/Toplo/actions/workflows/Pharo11CI.yml)

## Installation

```Smalltalk
Metacello new
         baseline: 'Toplo';
         repository: 'github://plantec/Toplo:dev-lookandfeel';
         onConflictUseIncoming;
         load
```
