Class {
	#name : #TcLabel,
	#superclass : #TcBasicWidget,
	#instVars : [
		'#textElement => ObservableSlot',
		'#alignment => ObservableSlot',
		'#text => ObservableSlot'
	],
	#category : #'Toploc-Widgets'
}

{ #category : #accessing }
TcLabel >> alignment [

	^ alignment
]

{ #category : #accessing }
TcLabel >> alignment: aSymbol [

	aSymbol ~= alignment ifFalse: [ ^ self ].
	alignment := aSymbol.
	self alignmentChanged
]

{ #category : #accessing }
TcLabel >> alignmentChanged [ 

	| block |
	self alignment = #left ifTrue:[
		block := [ :c |
			c frame horizontal alignLeft.
			c frame vertical alignCenter.
		].	
	].

	self alignment = #center ifTrue:[
		block := [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter.
		].	
	].

	self textElement constraintsDo: block.
	self  constraintsDo: [ :c | 
		c  horizontal fitContentLimited .
		c  vertical fitContentLimited. 
].
]

{ #category : #initialization }
TcLabel >> initialize [ 

	super initialize.
	
	self layout: BlFrameLayout new.
	
	textElement := BlTextElement new.
	textElement background: Color white.
	alignment := #left.
	self textChanged.
	self alignmentChanged.
	self addChild: textElement.
	

]

{ #category : #accessing }
TcLabel >> text [

	^ text
]

{ #category : #accessing }
TcLabel >> text: aStringOrBlRopedText [

	aStringOrBlRopedText ~= self text ifFalse: [ ^ self ].
	text := aStringOrBlRopedText.
	self textChanged
]

{ #category : #accessing }
TcLabel >> textChanged [ 

	self textElement text: ((self text ifNil:['']) asRopedText).
]

{ #category : #accessing }
TcLabel >> textElement [

	^ textElement
]
