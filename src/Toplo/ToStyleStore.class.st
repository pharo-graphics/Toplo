Class {
	#name : 'ToStyleStore',
	#superclass : 'Object',
	#traits : 'TToTokenPropertyIndexHolder',
	#classTraits : 'TToTokenPropertyIndexHolder classTrait',
	#instVars : [
		'tokenPropertyIndex'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [

	self tokenPropertyIndex changedAction: [ anElement requestNewSkin ]
]

{ #category : 't - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex [

	^ tokenPropertyIndex
]

{ #category : 't - token property index holder' }
ToStyleStore >> rawTokenPropertyIndex: aPropertyIndex [

	^ tokenPropertyIndex := aPropertyIndex
]

{ #category : 'adding-removing' }
ToStyleStore >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : 'adding-removing' }
ToStyleStore >> withStamp: anAssociationOrSymbol [

	self addTokenProperty: anAssociationOrSymbol asTokenProperty
]

{ #category : 'adding-removing' }
ToStyleStore >> withoutAllStamps [

	self tokenPropertyIndex removeAllProperties
]

{ #category : 'adding-removing' }
ToStyleStore >> withoutStamp: aSymbol [

	self removeTokenPropertyNamed: aSymbol 
]
