Trait {
	#name : 'TToReadOnlyStampIndexHolder',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> addAllReadOnlyStamps: aStyleStampCollection [

	self readOnlyStampIndex addAllProperties: aStyleStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> addReadOnlyStamp: aStyleStamp [

	self readOnlyStampIndex addProperty: aStyleStamp
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> localStampNamed: aSymbol [

	^ self rawReadOnlyStampIndex propertyNamed: aSymbol
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> lookUpStampNamed: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the stamp from the local styleStampIndex 
	"
	anElement withAllParentsDo: [ :p |
		(p toStyleStore localStampNamed: aSymbol) ifNotNil: [ :t | ^ t ] ].
	^ nil
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> newStampIndex [

	^ ToPropertyIndex new
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> rawReadOnlyStampIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> rawReadOnlyStampIndex: aPropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> readOnlyStampIndex [

	^ self rawReadOnlyStampIndex ifNil: [ self rawReadOnlyStampIndex: self newStampIndex. self rawReadOnlyStampIndex ]
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> readOnlyStampNamed: aName [

	^ self rawReadOnlyStampIndex ifNotNil: [ :si | si propertyNamed: aName ]
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> resetReadOnlyStampIndexFromList: aStyleStampCollection [

	self rawReadOnlyStampIndex: nil.
	self readOnlyStampIndex addAllProperties: aStyleStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> stampNamed: aName from: anElement [

	(self lookUpStampNamed: aName from: anElement) ifNotNil: [ :s | ^ s ].
	(ToElementPropertyNotFound name: aName) signal
]
