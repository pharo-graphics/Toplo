Trait {
	#name : #TToTokenPropertyIndexHolder,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> addAllTokenProperties: aTokenPropertyCollection [

	self tokenPropertyIndex addAllProperties: aTokenPropertyCollection
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> addTokenProperty: aTokenProperty [

	self tokenPropertyIndex addProperty: aTokenProperty
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> getTokenPropertyNamed: aSymbol [

	^ self rawTokenPropertyIndex propertyNamed: aSymbol
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> hasTokenPropertyNamed: aSymbol [

	^ self rawTokenPropertyIndex notNil and: [ self rawTokenPropertyIndex hasPropertyNamed: aSymbol ]
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> newTokenPropertyIndex [

	^ ToPropertyIndexWithChangedAction new
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> rawTokenPropertyIndex [

	^ self explicitRequirement 
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> rawTokenPropertyIndex: aPropertyIndex [

	^ self explicitRequirement 
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> removeAllTokenPropertiesFromNames: aCollection [

	self tokenPropertyIndex removeAllPropertiesFromNames: aCollection
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> removeTokenPropertyNamed: aSymbol [

	self tokenPropertyIndex removePropertyNamed: aSymbol
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyIndex [

	^ self rawTokenPropertyIndex ifNil: [
		  self rawTokenPropertyIndex: self newTokenPropertyIndex.
		  self rawTokenPropertyIndex ]
]

{ #category : #'t - token property index holder' }
TToTokenPropertyIndexHolder >> tokenPropertyNamed: aName [

	^ self rawTokenPropertyIndex ifNotNil: [ :si | si propertyNamed: aName ]
]
