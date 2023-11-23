Class {
	#name : 'ToStyleStore',
	#superclass : 'Object',
	#traits : 'TToReadOnlyStampIndexHolder',
	#classTraits : 'TToReadOnlyStampIndexHolder classTrait',
	#instVars : [
		'stampIndex',
		'borderBuilder',
		'styleSheet',
		'textAttributesBuilder',
		'themeClasses'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'adding-removing' }
ToStyleStore >> addStamp: aStyleStamp [

	self addReadOnlyStamp: aStyleStamp
]

{ #category : 'accessing' }
ToStyleStore >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ]
]

{ #category : 'testing' }
ToStyleStore >> hasStampNamed: aSymbol [

	^ self readOnlyStampIndex hasPropertyNamed: aSymbol
]

{ #category : 'api - hooks' }
ToStyleStore >> isSetUpForTheme: aTheme [

	^ self themeClasses includes: aTheme class
]

{ #category : 't - readonly stamp index holder' }
ToStyleStore >> lookUpStampNamed: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the stamp from the local styleStampIndex 
	"

	anElement withAllParentsDo: [ :p |
		(p toStyleStore localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ].
	" I'm in the space root. reaching here can mean that the theme is not installed. "
	anElement space ifNotNil: [ :sp | "reading the space toTheme should install the default raw theme"
		sp toTheme.
		" second try "
		^ self lookUpStampNamed: aSymbol from: anElement ].
	" really not found "
	^ nil
]

{ #category : 't - readonly stamp index holder' }
ToStyleStore >> newStampIndex [

	^ ToStyleStampIndex new
]

{ #category : 'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [

	themeClasses := IdentitySet new.
	self readOnlyStampIndex changedAction: [ anElement requestNewSkin ]
]

{ #category : 't - readonly stamp index holder' }
ToStyleStore >> rawReadOnlyStampIndex [

	^ stampIndex
]

{ #category : 't - readonly stamp index holder' }
ToStyleStore >> rawReadOnlyStampIndex: aPropertyIndex [

	^ stampIndex := aPropertyIndex
]

{ #category : 'api - hooks' }
ToStyleStore >> registerTheme: aTheme [

	self themeClasses add: aTheme class
]

{ #category : 'adding-removing' }
ToStyleStore >> removeStampNamed: aSymbol [

	self readOnlyStampIndex removePropertyNamed: aSymbol
]

{ #category : 'api - hooks' }
ToStyleStore >> setUpForTheme: aTheme in: anElement [

	(self isSetUpForTheme: aTheme) ifTrue: [ ^ self ].
	self registerTheme: aTheme.
	aTheme setUpElementForTheme: anElement
]

{ #category : 'accessing' }
ToStyleStore >> stampValue: aSymbol from: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : 'accessing' }
ToStyleStore >> styleSheet [

	^ styleSheet
]

{ #category : 'accessing' }
ToStyleStore >> styleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUnInstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ]
]

{ #category : 'accessing' }
ToStyleStore >> styleSheetChainIn: anElement [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current toStyleStore styleSheet  ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ] ]
]

{ #category : 'accessing' }
ToStyleStore >> textAttributesBuilder [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := BlTextAttributesBuilder new ]
]

{ #category : 'accessing' }
ToStyleStore >> themeClasses [

	^ themeClasses
]

{ #category : 'adding-removing' }
ToStyleStore >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : 'adding-removing' }
ToStyleStore >> withStamp: anAssociationOrSymbol [

	self addStamp: anAssociationOrSymbol asStyleStamp
]

{ #category : 'adding-removing' }
ToStyleStore >> withoutAllStamps [

	self readOnlyStampIndex removeAllProperties
]

{ #category : 'adding-removing' }
ToStyleStore >> withoutStamp: aSymbol [

	self removeStampNamed: aSymbol 
]
