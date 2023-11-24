Class {
	#name : 'ToStyleStore',
	#superclass : 'Object',
	#traits : 'TToReadOnlyPropertyIndexHolder',
	#classTraits : 'TToReadOnlyPropertyIndexHolder classTrait',
	#instVars : [
		'stampIndex'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'adding-removing' }
ToStyleStore >> addStamp: aStyleStamp [

	self addReadOnlyStamp: aStyleStamp
]

{ #category : 'testing' }
ToStyleStore >> hasStampNamed: aSymbol [

	^ self readOnlyStampIndex hasPropertyNamed: aSymbol
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
		^ self localStampNamed: aSymbol ].
	" really not found "
	^ nil
]

{ #category : 't - readonly stamp index holder' }
ToStyleStore >> newStampIndex [

	^ ToStyleStampIndex new
]

{ #category : 'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [

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

{ #category : 'adding-removing' }
ToStyleStore >> removeStampNamed: aSymbol [

	self readOnlyStampIndex removePropertyNamed: aSymbol
]

{ #category : 'accessing' }
ToStyleStore >> stampValue: aSymbol from: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
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
