Class {
	#name : #ToLabelLook,
	#superclass : #ToElementLook,
	#instVars : [
		'attrBuilder',
		'pressedColor',
		'hoverColor',
		'initialColor'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #accessing }
ToLabelLook >> attrBuilder [

	^ attrBuilder 
]

{ #category : #accessing }
ToLabelLook >> attrBuilder: aTextAttributesBuilder [

	attrBuilder := aTextAttributesBuilder
]

{ #category : #accessing }
ToLabelLook >> attributes [

	^ self attrBuilder attributes
]

{ #category : #initialization }
ToLabelLook >> defaultAttrBuilder [

	^ BlTextAttributesBuilder new
]

{ #category : #accessing }
ToLabelLook >> defaultFontName: aString [

	self attrBuilder defaultFontName: aString
]

{ #category : #accessing }
ToLabelLook >> defaultFontSize: aNumber [

	self attrBuilder defaultFontSize: aNumber
]

{ #category : #accessing }
ToLabelLook >> foreground: aColor [

	self attrBuilder foreground: aColor
]

{ #category : #accessing }
ToLabelLook >> hoverColor [

	^ hoverColor
]

{ #category : #accessing }
ToLabelLook >> hoverColor: anObject [

	hoverColor := anObject
]

{ #category : #accessing }
ToLabelLook >> initialColor [

	^ initialColor
]

{ #category : #accessing }
ToLabelLook >> initialColor: aColor [

	initialColor := aColor
]

{ #category : #'event handling' }
ToLabelLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialColor ifNil: [ ^ self ].
	self foreground: self initialColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #initialization }
ToLabelLook >> initialize [ 

	super initialize.
	attrBuilder := self defaultAttrBuilder
]

{ #category : #accessing }
ToLabelLook >> lineSpacing: aNumber [

	self attrBuilder lineSpacing: aNumber
]

{ #category : #'event handling' }
ToLabelLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	self hoverColor ifNil: [ ^ self ].
	self foreground: self hoverColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #'event handling' }
ToLabelLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	self pressedColor ifNil: [ ^ self ].
	self foreground: self pressedColor.
	anEvent target text attributes: self attributes.
	anEvent target textChanged
]

{ #category : #accessing }
ToLabelLook >> pressedColor [

	^ pressedColor
]

{ #category : #accessing }
ToLabelLook >> pressedColor: anObject [

	pressedColor := anObject
]

{ #category : #private }
ToLabelLook >> textAttributesBuilderFromElement: anElement [

	| builder |
	builder  := BlTextAttributesBuilder new.
	builder lineSpacing: anElement toTheme lineHeight.
	builder defaultFontSize: anElement toTheme fontSize.
	builder defaultFontName: anElement toTheme fontFamilyCode.
	builder foreground: anElement toTheme colorText.

	^ builder 
]
