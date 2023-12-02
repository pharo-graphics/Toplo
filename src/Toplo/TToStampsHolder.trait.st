Trait {
	#name : 'TToStampsHolder',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 't - stamps holder' }
TToStampsHolder >> addAllStamps: aSymbolCollection [

	self stampIndex addAllProperties: (aSymbolCollection collect: [ :s | s-> true ])
]

{ #category : 't - stamps holder' }
TToStampsHolder >> addStamp: aSymbol [

	self stampIndex addProperty: (aSymbol -> true)
]

{ #category : 't - stamps holder' }
TToStampsHolder >> allStamps [

	^ self stampIndex allPropertyNames
]

{ #category : 't - stamps holder' }
TToStampsHolder >> hasAllStamps: aSymbolCollection [

	^ aSymbolCollection allSatisfy: [ :s | self hasStamp: s ]
]

{ #category : 't - stamps holder' }
TToStampsHolder >> hasStamp: aSymbol [

	^ self stampIndex hasPropertyNamed: aSymbol
]

{ #category : 't - stamps holder' }
TToStampsHolder >> rawStampIndex [

	^ self explicitRequirement 
]

{ #category : 't - stamps holder' }
TToStampsHolder >> rawStampIndex: aPropertyIndex [

	self explicitRequirement 
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeAllStamps [

	self stampIndex removeAllProperties
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeAllStamps: aSymbolCollection [

	self stampIndex removeAllPropertyFromNames: aSymbolCollection
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeStamp: aSymbol [

	self stampIndex removePropertyNamed: aSymbol
]

{ #category : 't - stamps holder' }
TToStampsHolder >> stampIndex [

	^ self rawStampIndex ifNil: [
		  self rawStampIndex: ToPropertyIndexWithChangedAction new.
		  self rawStampIndex ]
]
