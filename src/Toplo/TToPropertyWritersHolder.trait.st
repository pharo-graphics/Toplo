Trait {
	#name : 'TToPropertyWritersHolder',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> addAllPropertyWriters: aPropertyWriterCollection [

	self rawPropertyWriters: (self rawPropertyWriters copyWithAll: aPropertyWriterCollection)
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> addPropertyWriter: aPropertyWriter [

	self rawPropertyWriters: (self rawPropertyWriters copyWith: aPropertyWriter)
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> propertyWriters [

	^ self rawPropertyWriters 
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> propertyWriters: aPropertyWriterCollection [

	^ self rawPropertyWriters: aPropertyWriterCollection
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> rawPropertyWriters [

	^ self explicitRequirement 
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> rawPropertyWriters: aPropertyWriterCollection [

	self explicitRequirement
]

{ #category : 't - property writers holder - accessing' }
TToPropertyWritersHolder >> removeAllPropertyWriters: aPropertyWriterCollection [

	self rawPropertyWriters: (self rawPropertyWriters copyWithoutAll: aPropertyWriterCollection)
]
