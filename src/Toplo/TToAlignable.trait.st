Trait {
	#name : #TToAlignable,
	#instVars : [
		'hAlignment',
		'vAlignment'
	],
	#category : #'Toplo-Core'
}

{ #category : #private }
TToAlignable >> alignmentTarget [

	self shouldBeImplemented
]

{ #category : #'default values' }
TToAlignable >> defaultHAlignment [

	^#left
]

{ #category : #'default values' }
TToAlignable >> defaultVAlignment [

	^#center
]

{ #category : #'accessing-alignment' }
TToAlignable >> hAlignment [

	^hAlignment
]

{ #category : #'accessing-alignment' }
TToAlignable >> hAlignment: aSymbol [

	| newAlignment |
	newAlignment := aSymbol ifNil:[self defaultHAlignment].
	hAlignment ~= newAlignment ifFalse:[^self].
	hAlignment := newAlignment.	
	self hAlignmentChanged.
]

{ #category : #private }
TToAlignable >> hAlignmentChanged [

	self hAlignment = #center ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame horizontal alignCenter ].
		^ self ].
	self hAlignment = #left ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame horizontal alignLeft ].
		^ self ].
	self hAlignment = #right ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame horizontal alignRight ].
		^ self ].
	self alignmentTarget constraintsDo: [ :c | 
		c frame horizontal alignNone ].
]

{ #category : #'accessing-alignment' }
TToAlignable >> vAlignment [

	^vAlignment 
]

{ #category : #'accessing-alignment' }
TToAlignable >> vAlignment: aSymbol [

	| newAlignment |
	newAlignment := aSymbol ifNil:[self defaultVAlignment].
	vAlignment ~= newAlignment ifFalse:[^self].
	vAlignment := newAlignment.	
	self vAlignmentChanged.
]

{ #category : #private }
TToAlignable >> vAlignmentChanged [

	self vAlignment = #center ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame vertical alignCenter ].
		^ self ].
	self vAlignment = #top ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame vertical alignTop ].
		^ self ].
	self vAlignment = #bottom ifTrue: [ 
		self alignmentTarget constraintsDo: [ :c | 
			c frame vertical alignBottom ].
		^ self ].

	self alignmentTarget constraintsDo: [ :c | 
		c frame vertical alignNone ].
]
