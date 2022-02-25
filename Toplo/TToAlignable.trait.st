Trait {
	#name : #TToAlignable,
	#category : #'Toplo-Widgets'
}

{ #category : #'accessing-alignment' }
TToAlignable >> hAlignment: aSymbol [

	aSymbol = #matchParent ifTrue: [ 
		self alignmentTarget parent constraintsDo: [ :c | 
			c horizontal matchParent ].
		^ self ].
	aSymbol = #fitContent ifTrue: [ 
		self alignmentTarget parent constraintsDo: [ :c | c horizontal fitContent ].
		^ self ].
	aSymbol = #center ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame horizontal alignCenter ].
		^ self ].
	aSymbol = #left ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame horizontal alignLeft ].
		^ self ].
	aSymbol = #right ifFalse: [ ^ self ].
	self alignmentTarget constraintsDo: [ :c | 
		c frame horizontal alignRight ].
	^ self
]

{ #category : #'accessing-alignment' }
TToAlignable >> vAlignment: aSymbol [

	aSymbol = #matchParent ifTrue: [ 
		self alignmentTarget parent constraintsDo: [ :c | c vertical matchParent ].
		^ self ].
	aSymbol = #fitContent ifTrue: [ 
		self alignmentTarget parent constraintsDo: [ :c | 
			c vertical fitContent ].
		^ self ].
	aSymbol = #center ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame vertical alignCenter ].
		^ self ].
	aSymbol = #top ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame vertical alignTop ].
		^ self ].
	aSymbol = #bottom ifFalse: [ ^ self ].
	self alignmentTarget constraintsDo: [ :c | 
		c frame vertical alignBottom ].
	^ self
]
