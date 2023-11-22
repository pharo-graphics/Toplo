Trait {
	#name : 'TToWritablePropertyIndexHolder',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> defaultWritablePropertyList [

	^ self explicitRequirement 
]

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> property: aSymbol [

	^ self writablePropertyNamed: aSymbol
]

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> rawWritablePropertyIndex [

	^ self explicitRequirement 
]

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> rawWritablePropertyIndex: aPropertyIndex [

	self explicitRequirement 
]

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> writablePropertyIndex [

	^ self rawWritablePropertyIndex ifNil: [
		  self rawWritablePropertyIndex: ToPropertyIndex new.
		  self rawWritablePropertyIndex addAllProperties: self defaultWritablePropertyList.
		  self rawWritablePropertyIndex ]
]

{ #category : 't - writable property index holder' }
TToWritablePropertyIndexHolder >> writablePropertyNamed: aName [

	^ self writablePropertyIndex propertyNamed: aName
]
