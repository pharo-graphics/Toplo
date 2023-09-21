Trait {
	#name : #TToPropertyWriterHolder,
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> addAllWriters: aPropertyWriterCollection [

	self rawWriters: (self rawWriters copyWithAll: aPropertyWriterCollection)
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> addWriter: aPropertyWriter [

	self rawWriters: (self rawWriters copyWith: aPropertyWriter)
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> rawWriters [

	^ self explicitRequirement 
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> rawWriters: aPropertyWriterCollection [

	self explicitRequirement
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> removeAllWriters: aPropertyWriterCollection [

	self rawWriters: (self rawWriters copyWithoutAll: aPropertyWriterCollection)
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> writers [

	^ self rawWriters 
]

{ #category : #'t - property writer holder - accessing' }
TToPropertyWriterHolder >> writers: aPropertyWriterCollection [

	^ self rawWriters: aPropertyWriterCollection
]
