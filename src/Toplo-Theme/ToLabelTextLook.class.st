Class {
	#name : #ToLabelTextLook,
	#superclass : #ToElementLook,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'attrBuilder',
		'pressedColor',
		'hoverColor',
		'initialColor',
		'disabledColor',
		'selectedColor'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToLabelTextLook >> attributes [

	^ self attributesBuilder attributes
]

{ #category : #accessing }
ToLabelTextLook >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^  attrBuilder 
]

{ #category : #initialization }
ToLabelTextLook >> defaultAttributeBuilder [

	^ BlTextAttributesBuilder new
]

{ #category : #accessing }
ToLabelTextLook >> disabledColor [

	^ disabledColor
]

{ #category : #accessing }
ToLabelTextLook >> disabledColor: aValuable [

	disabledColor := aValuable
]

{ #category : #'event handling' }
ToLabelTextLook >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	self disabledColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self foreground: (self disabledColor value: e) ].
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #accessing }
ToLabelTextLook >> hoverColor [

	^ hoverColor
]

{ #category : #accessing }
ToLabelTextLook >> hoverColor: aValuable [

	hoverColor := aValuable
]

{ #category : #'event handling' }
ToLabelTextLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self hoverColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self foreground: (self hoverColor value: e) ].
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #accessing }
ToLabelTextLook >> initialColor [

	^ initialColor
]

{ #category : #accessing }
ToLabelTextLook >> initialColor: aValuable [

	initialColor := aValuable
]

{ #category : #'event handling' }
ToLabelTextLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self foreground: (self initialColor value: e) ].
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #initialization }
ToLabelTextLook >> initialize [ 

	super initialize.
	attrBuilder := self defaultAttributeBuilder
]

{ #category : #accessing }
ToLabelTextLook >> pressedColor [

	^ pressedColor
]

{ #category : #accessing }
ToLabelTextLook >> pressedColor: aValuable [

	pressedColor := aValuable
]

{ #category : #'event handling' }
ToLabelTextLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	self pressedColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self foreground: (self pressedColor value: e) ].
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #accessing }
ToLabelTextLook >> selectedColor [

	^ selectedColor
]

{ #category : #accessing }
ToLabelTextLook >> selectedColor: aValuable [

	selectedColor := aValuable
]

{ #category : #'event handling' }
ToLabelTextLook >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
	self selectedColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self foreground: (self selectedColor value: e) ].
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]
