# Toplo

A widget framework on top of Bloc.

## Installation

```Smalltalk
Metacello new
	baseline: 'Toplo';
	repository: 'github://plantec/Toplo/src';
	onConflictUseIncoming;
	load
```

## Look and feel features

A look and feel management is currently in development in a dedicated branch : dev-lookandfeel.

The evolutions from master branch are regularly integrated into this development branch.

This branch contains some examples to use the default Toplot look and feel inspired by [Ant Design](https://github.com/ant-design/ant-design) or create your own themes and skins.

```Smalltalk
Metacello new
	baseline: 'Toplo';
	repository: 'github://plantec/Toplo/src:dev-lookandfeel';
	onConflictUseIncoming;
	load
```
