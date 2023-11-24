Trait {
	#name : 'TToReadOnlyPropertyIndexHolder',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> addAllReadOnlyStamps: aStyleStampCollection [

	self readOnlyStampIndex addAllProperties: aStyleStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> addReadOnlyStamp: aStyleStamp [

	self readOnlyStampIndex addProperty: aStyleStamp
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> localStampNamed: aSymbol [

	^ self rawReadOnlyStampIndex propertyNamed: aSymbol
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> lookUpStampNamed: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the stamp from the local styleStampIndex 
	"
	anElement withAllParentsDo: [ :p |
		(p toStyleStore localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ].
	^ nil
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> newStampIndex [

	^ ToPropertyIndex new
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> rawReadOnlyStampIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> rawReadOnlyStampIndex: aPropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> readOnlyStampIndex [

	^ self rawReadOnlyStampIndex ifNil: [ self rawReadOnlyStampIndex: self newStampIndex. self rawReadOnlyStampIndex ]
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> readOnlyStampNamed: aName [

	^ self rawReadOnlyStampIndex ifNotNil: [ :si | si propertyNamed: aName ]
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> stampList: aStampCollection [

	self readOnlyStampIndex addAllProperties: aStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyPropertyIndexHolder >> stampNamed: aName from: anElement [

	(self lookUpStampNamed: aName from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aName) signal
]
