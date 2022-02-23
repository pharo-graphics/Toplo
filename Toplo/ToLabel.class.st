Class {
	#name : #ToLabel,
	#superclass : #ToBasicWidget,
	#instVars : [
		'#textElement => ObservableSlot',
		'#alignment => ObservableSlot',
		'#text => ObservableSlot',
		'#fontName => ObservableSlot',
		'#fontSize => ObservableSlot'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #accessing }
ToLabel >> alignment [

	^ alignment
]

{ #category : #accessing }
ToLabel >> alignment: aSymbol [

	aSymbol ~= alignment ifFalse: [ ^ self ].
	alignment := aSymbol.
	self alignmentChanged
]

{ #category : #accessing }
ToLabel >> alignmentChanged [ 

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

{ #category : #font }
ToLabel >> fontName [ 
	^fontName
]

{ #category : #font }
ToLabel >> fontName: aString [
	self fontName ~= aString ifFalse: [ ^self ].
	fontName := aString.
	self fontNameChanged
]

{ #category : #font }
ToLabel >> fontNameChanged [

	self textElement text fontName: self fontName
]

{ #category : #font }
ToLabel >> fontSize [

	^ fontSize
]

{ #category : #font }
ToLabel >> fontSize: aNumber [

	self fontSize ~= aNumber ifFalse: [ ^ self ].
	fontSize := aNumber.
	self fontSizeChanged
]

{ #category : #font }
ToLabel >> fontSizeChanged [

	self textElement text fontSize: self fontSize
]

{ #category : #initialization }
ToLabel >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	textElement := BlTextElement new.
	textElement background: self defaultBackground. 
	alignment := #left.
	self textChanged.
	self alignmentChanged.
	self addChild: textElement
]

{ #category : #accessing }
ToLabel >> text [

	^ text
]

{ #category : #accessing }
ToLabel >> text: aStringOrBlText [

	aStringOrBlText ~= self text ifFalse: [ ^ self ].
	text := aStringOrBlText.
	self textChanged
]

{ #category : #accessing }
ToLabel >> textChanged [ 

	self textElement text: ((self text ifNil:['']) asRopedText).
]

{ #category : #accessing }
ToLabel >> textElement [

	^ textElement
]
