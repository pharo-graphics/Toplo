Class {
	#name : #ToLabelTextLook,
	#superclass : #ToDefaultElementLook,
	#instVars : [
		'attrBuilder',
		'pressedColor',
		'hoverColor',
		'initialColor'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #accessing }
ToLabelTextLook >> attrBuilder [

	^ attrBuilder 
]

{ #category : #accessing }
ToLabelTextLook >> attrBuilder: aTextAttributesBuilder [

	attrBuilder := aTextAttributesBuilder
]

{ #category : #accessing }
ToLabelTextLook >> attributes [

	^ self attrBuilder attributes
]

{ #category : #initialization }
ToLabelTextLook >> defaultAttrBuilder [

	^ BlTextAttributesBuilder new
]

{ #category : #accessing }
ToLabelTextLook >> defaultFontName: aString [

	self attrBuilder defaultFontName: aString
]

{ #category : #accessing }
ToLabelTextLook >> defaultFontSize: aNumber [

	self attrBuilder defaultFontSize: aNumber
]

{ #category : #accessing }
ToLabelTextLook >> foreground: aColor [

	self attrBuilder foreground: aColor
]

{ #category : #accessing }
ToLabelTextLook >> hoverColor [

	^ hoverColor
]

{ #category : #accessing }
ToLabelTextLook >> hoverColor: anObject [

	hoverColor := anObject
]

{ #category : #'event handling' }
ToLabelTextLook >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self hoverColor ifNil: [ ^ self ].
	self foreground: self hoverColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #accessing }
ToLabelTextLook >> initialColor [

	^ initialColor
]

{ #category : #accessing }
ToLabelTextLook >> initialColor: aColor [

	initialColor := aColor
]

{ #category : #'event handling' }
ToLabelTextLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialColor ifNil: [ ^ self ].
	self foreground: self initialColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #initialization }
ToLabelTextLook >> initialize [ 

	super initialize.
	attrBuilder := self defaultAttrBuilder
]

{ #category : #accessing }
ToLabelTextLook >> lineSpacing: aNumber [

	self attrBuilder lineSpacing: aNumber
]

{ #category : #accessing }
ToLabelTextLook >> pressedColor [

	^ pressedColor
]

{ #category : #accessing }
ToLabelTextLook >> pressedColor: anObject [

	pressedColor := anObject
]

{ #category : #'event handling' }
ToLabelTextLook >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	self pressedColor ifNil: [ ^ self ].
	self foreground: self pressedColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]
