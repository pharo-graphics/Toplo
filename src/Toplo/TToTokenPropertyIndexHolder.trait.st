Trait {
	#name : 'TToTokenPropertyIndexHolder',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> addAllTokenProperties: aTokenPropertyCollection [

	self tokenPropertyIndex addAllProperties: aTokenPropertyCollection
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> addTokenProperty: aTokenProperty [

	self tokenPropertyIndex addProperty: aTokenProperty
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> hasTokenPropertyNamed: aSymbol [

	^ self rawTokenPropertyIndex notNil and: [ self rawTokenPropertyIndex hasPropertyNamed: aSymbol ]
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> localTokenPropertyNamed: aSymbol [

	^ self rawTokenPropertyIndex propertyNamed: aSymbol
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> lookUpTokenPropertyNamed: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the stamp from the local styleStampIndex 
	"

	anElement withAllParentsDo: [ :p |
		(p toStyleStore localTokenPropertyNamed: aSymbol) ifNotNil: [ :t | ^ t ] ].
	" I'm in the space root. reaching here can mean that the theme is not installed. "
	anElement space ifNotNil: [ :sp | "reading the space toTheme should install the default raw theme"
		sp toTheme.
		" second try "
		^ self localTokenPropertyNamed: aSymbol ].
	" really not found "
	^ nil
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> newTokenPropertyIndex [

	^ ToPropertyIndexWithChangedAction new
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> rawTokenPropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> rawTokenPropertyIndex: aPropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> removeTokenPropertyNamed: aSymbol [

	self tokenPropertyIndex removePropertyNamed: aSymbol
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyIndex [

	^ self rawTokenPropertyIndex ifNil: [
		  self rawTokenPropertyIndex: self newTokenPropertyIndex.
		  self rawTokenPropertyIndex ]
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyNamed: aName [

	^ self rawTokenPropertyIndex ifNotNil: [ :si | si propertyNamed: aName ]
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyNamed: aName from: anElement [

	(self lookUpTokenPropertyNamed: aName from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aName) signal
]

{ #category : 't - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyValue: aSymbol from: anElement [

	^ (self tokenPropertyNamed: aSymbol from: anElement) value
]
