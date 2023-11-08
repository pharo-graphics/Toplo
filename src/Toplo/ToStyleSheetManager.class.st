Class {
	#name : 'ToStyleSheetManager',
	#superclass : 'Object',
	#instVars : [
		'stampIndex',
		'borderBuilder',
		'styleSheet'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'adding-removing' }
ToStyleSheetManager >> addStyleStamp: aStyleStamp [

	self stampIndex addProperty: aStyleStamp
]

{ #category : 'accessing' }
ToStyleSheetManager >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ]
]

{ #category : 'testing' }
ToStyleSheetManager >> hasStamp: aSymbol [

	^ self stampIndex hasPropertyNamed: aSymbol
]

{ #category : 'initialization' }
ToStyleSheetManager >> initialize [ 

	super initialize.
	stampIndex := ToPropertyIndex new
]

{ #category : 'accessing' }
ToStyleSheetManager >> localStampNamed: aSymbol [

	^ self stampIndex propertyNamed: aSymbol
]

{ #category : 'lookup' }
ToStyleSheetManager >> lookUpStampNamed: aSymbol from: anElement [
	" first look-up following child-parent association 
	for each element, try first to get the stamp from the localStyleStampIndex 
	then from the elementl styleSheet ifPresent"
self flag: 'uniform naming required localStampNamed/stampNamed'.
	anElement withAllParentsDo: [ :p |
		(p toStyleSheetManager localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ].
		p toStyleSheetManager styleSheet ifNotNil: [ :ss |
			(ss stampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ] ].
	" finally, try to get the stamp from the theme "
	^ anElement toTheme stampNamed: aSymbol
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> removeAllStyleStamps [

	self stampIndex removeAllProperties 
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> removeAllStyleStamps: aStyleStampCollection [

	aStyleStampCollection do: [ :s | self stampIndex removeProperty: s ]
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> removeStyleStamp: aStyleStamp [

	self stampIndex removeProperty: aStyleStamp
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> removeStyleStampNamed: aSymbol [

	self stampIndex removePropertyNamed: aSymbol
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> removeStyleStampNamed: aSymbol ifAbsent: anAbsentBlock [

	self stampIndex removePropertyNamed: aSymbol ifAbsent: anAbsentBlock
]

{ #category : 'accessing' }
ToStyleSheetManager >> stampIndex [

	^ stampIndex
]

{ #category : 'accessing' }
ToStyleSheetManager >> stampNamed: aSymbol in: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : 'accessing' }
ToStyleSheetManager >> stampValue: aSymbol in: anElement [

	(self lookUpStampNamed: aSymbol from: anElement) ifNotNil: [ :s | ^ s value ].
	(ToElementPropertyNotFound name: aSymbol) signal
]

{ #category : 'accessing' }
ToStyleSheetManager >> styleSheet [

	^ styleSheet
]

{ #category : 'accessing' }
ToStyleSheetManager >> styleSheet: aStyleSheet [

	styleSheet := aStyleSheet
]

{ #category : 'accessing' }
ToStyleSheetManager >> styleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUnInstalledIn: anElement ].
	self styleSheet: aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ]
]

{ #category : 'accessing' }
ToStyleSheetManager >> styleSheetChainIn: anElement [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits th |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current localStyleSheet ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ].
		  th := anElement toTheme.
		  (th notNil and: [ th styleSheet notNil and: [ inherits ] ])
			  ifTrue: [ str nextPut: th styleSheet ] ]
]

{ #category : 'testing' }
ToStyleSheetManager >> styleStampNamed: aSymbol [

	^ self stampIndex propertyNamed: aSymbol ifAbsent: [  ]
	
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> withAllStamps: aCollectionOfSymbol [

	aCollectionOfSymbol ifEmpty: [ ^ self ].
	aCollectionOfSymbol do: [ :s | self withStamp: s ]
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> withStamp: anAssociationOrSymbol [

	self withStamp: anAssociationOrSymbol asStyleStamp
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> withoutAllStamps [

	self removeAllStyleStamps
]

{ #category : 'adding-removing' }
ToStyleSheetManager >> withoutStamp: aSymbol [

	self removeStyleStampNamed: aSymbol ifAbsent: [  ]
]
