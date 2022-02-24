Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'#textElement => ObservableSlot',
		'#alignment',
		'#text'
	],
	#classInstVars : [
		'#alignIdx'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToLabel class >> alignmentIndexes [
	alignIdx ifNotNil: [ ^ alignIdx  ].
	alignIdx := IdentityDictionary new.
	alignIdx at: #left put: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	alignIdx at: #topLeft put: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	alignIdx at: #right put: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	alignIdx at: #topRight put: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	alignIdx at: #center put: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	alignIdx at: #leftCenter put: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	alignIdx at: #rightCenter put: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	alignIdx at: #topCenter put: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	alignIdx at: #bottomCenter put: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	alignIdx at: #top put: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	alignIdx at: #bottom put: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	alignIdx at: #bottomLeft put: [ :c | 
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].
	alignIdx at: #bottomRight put: [ :c | 
		c frame horizontal alignRight.
		c frame vertical alignBottom ].
	^ alignIdx
]

{ #category : #alignment }
ToLabel >> alignment [

	^ alignment
]

{ #category : #alignment }
ToLabel >> alignment: aSymbol [

	aSymbol ~= alignment ifFalse: [ ^ self ].
	alignment := aSymbol.
	self alignmentChanged
]

{ #category : #alignment }
ToLabel >> alignmentChanged [


	self textElement constraintsDo: (self alignmentIndexes at: self alignment)
]

{ #category : #alignment }
ToLabel >> alignmentIndexes [
	^ self class alignmentIndexes
]

{ #category : #accessing }
ToLabel >> attributesBuilder [

	<return: #BlTextAttributesBuilder>
	^ self textElement attributesBuilder 
]

{ #category : #initialization }
ToLabel >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	textElement := BlAttributedTextElement new.
	textElement background: self defaultBackground.
	self addChild: textElement.
	alignment := #center.
	self textChanged.
	self alignmentChanged.

]

{ #category : #accessing }
ToLabel >> text [

	^ text ifNil: [ '' ]
]

{ #category : #accessing }
ToLabel >> text: aStringOrBlText [

	aStringOrBlText ~= self text ifFalse: [ ^ self ].
	text := aStringOrBlText asString.
	self textChanged
]

{ #category : #accessing }
ToLabel >> textChanged [

	self textElement text: (self text ifNil: [ '' ]) asRopedText

]

{ #category : #accessing }
ToLabel >> textElement [

	^ textElement
]
