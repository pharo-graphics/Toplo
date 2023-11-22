Trait {
	#name : 'TToReadOnlyStampIndexHolder',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> addAllStamps: aStyleStampCollection [

	self stampIndex addAllProperties: aStyleStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> rawStampIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> rawStampIndex: aPropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> resetStampIndexFromList: aStyleStampCollection [

	self rawStampIndex: nil.
	self stampIndex addAllProperties: aStyleStampCollection
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> stampIndex [

	^ self rawStampIndex ifNil: [ self rawStampIndex: ToPropertyIndex new. self rawStampIndex ]
]

{ #category : 't - readonly stamp index holder' }
TToReadOnlyStampIndexHolder >> stampNamed: aName [

	^ self rawStampIndex ifNotNil: [ :si | si propertyNamed: aName ]
]
