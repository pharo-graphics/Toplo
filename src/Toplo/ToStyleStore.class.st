Class {
	#name : 'ToStyleStore',
	#superclass : 'Object',
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

	self readOnlyStampIndex addProperty: aStyleStamp
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

{ #category : 'accessing' }
ToStyleStore >> localStampNamed: aSymbol [

	^ self readOnlyStampIndex propertyNamed: aSymbol
]

{ #category : 'lookup' }
ToStyleStore >> lookUpStampNamed: aSymbol from: anElement [
	" first look-up following child-parent association 
	for each element, try first to get the stamp from the localStyleStampIndex 
	then from the elementl styleSheet ifPresent"
	anElement withAllParentsDo: [ :p |
		(p toStyleStore localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ].
		p toStyleStore styleSheet ifNotNil: [ :ss |
			(ss stampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ] ].
	" finally, try to get the stamp from the theme "
	^ anElement toTheme stampNamed: aSymbol
]

{ #category : 'api - hooks' }
ToStyleStore >> onInstalledIn: anElement [

	themeClasses := IdentitySet new.
	self readOnlyStampIndex changedAction: [ anElement requestNewSkin ]
]

{ #category : 'accessing' }
ToStyleStore >> readOnlyStampIndex [

	^ stampIndex ifNil: [ stampIndex := ToStyleStampIndex new ]
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
	aTheme onSetUpIn: anElement
]

{ #category : 'accessing' }
ToStyleStore >> stampNamed: aSymbol from: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aSymbol) signal
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
		  | current inherits th |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current toStyleStore styleSheet  ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ].
		  th := anElement toTheme.
		  (th notNil and: [ th styleSheet notNil and: [ inherits ] ])
			  ifTrue: [ str nextPut: th styleSheet ] ]
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
