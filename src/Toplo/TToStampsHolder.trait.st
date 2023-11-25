Trait {
	#name : 'TToStampsHolder',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 't - stamps holder' }
TToStampsHolder >> addAllStamps: aSymbolCollect [

	self stampSet addAll: aSymbolCollect
]

{ #category : 't - stamps holder' }
TToStampsHolder >> addStamp: aSymbol [

	self stampSet add: aSymbol
]

{ #category : 't - stamps holder' }
TToStampsHolder >> allStamps [

	^ self stampSet asArray
]

{ #category : 't - stamps holder' }
TToStampsHolder >> hasAllStamps: aSymbolCollection [

	self stampSet includesAll: aSymbolCollection
]

{ #category : 't - stamps holder' }
TToStampsHolder >> hasStamp: aSymbol [

	^ self stampSet includes: aSymbol
]

{ #category : 't - stamps holder' }
TToStampsHolder >> rawStampSet [

	^ self explicitRequirement 
]

{ #category : 't - stamps holder' }
TToStampsHolder >> rawStampSet: aSet [

	self explicitRequirement 
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeAllStamps [

	self stampSet removeAll
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeAllStamps: aSymbolCollect [

	self stampSet removeAll: aSymbolCollect
]

{ #category : 't - stamps holder' }
TToStampsHolder >> removeStamp: aSymbol [

	self stampSet remove: aSymbol
]

{ #category : 't - stamps holder' }
TToStampsHolder >> stampSet [

	^ self rawStampSet ifNil: [
		  self rawStampSet: ToStampSet new.
		  self rawStampSet ]
]
