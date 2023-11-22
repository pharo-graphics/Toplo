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
TToReadOnlyStampIndexHolder >> defaultReadOnlyStampList [

	^ self explicitRequirement 
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

	^ self rawReadOnlyStampIndex ifNil: [ self rawReadOnlyStampIndex: ToPropertyIndex new. self rawReadOnlyStampIndex ]
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
TToReadOnlyStampIndexHolder >> stampNamed: aName [

	^ self readOnlyStampNamed: aName
]
