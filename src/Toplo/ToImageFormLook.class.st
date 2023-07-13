Class {
	#name : #ToImageFormLook,
	#superclass : #ToElementLook,
	#instVars : [
		'initialColor',
		'hoverColor',
		'pressedColor'
	],
	#category : #'Toplo-Core-Theme-Looks'
}

{ #category : #'event handling' }
ToImageFormLook >> adaptForegroundIn: anElement withColor: aColor [

	anElement
		withInnerFormDo: [ :form |
			| newForm |
			newForm := form collectColors: [ :color | aColor alpha: color alpha ].
			anElement innerImage: newForm ]
		ifNone: [  ]
]

{ #category : #accessing }
ToImageFormLook >> hoverColor [

	^ hoverColor
]

{ #category : #accessing }
ToImageFormLook >> hoverColor: aColor [

	hoverColor := aColor
]

{ #category : #accessing }
ToImageFormLook >> initialColor [

	^ initialColor
]

{ #category : #accessing }
ToImageFormLook >> initialColor: aColor [

	initialColor := aColor
]

{ #category : #'event handling' }
ToImageFormLook >> initialLookEvent: anEvent [

	super initialLookEvent: anEvent.
	self initialColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: self initialColor ]
]

{ #category : #'event handling' }
ToImageFormLook >> mouseHoverLookEvent: anEvent [

	super mouseHoverLookEvent: anEvent.
	self hoverColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: self hoverColor ]
]

{ #category : #'event handling' }
ToImageFormLook >> mousePressedLookEvent: anEvent [

	super mousePressedLookEvent: anEvent.
	self pressedColor ifNil: [ ^ self ].
	anEvent elementDo: [ :e |
		self adaptForegroundIn: e withColor: self pressedColor ]
]

{ #category : #accessing }
ToImageFormLook >> pressedColor [

	^ pressedColor
]

{ #category : #accessing }
ToImageFormLook >> pressedColor: aColor [

	pressedColor := aColor
]
