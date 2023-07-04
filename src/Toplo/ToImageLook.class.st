Class {
	#name : #ToImageLook,
	#superclass : #ToElementLook,
	#instVars : [
		'foreColor'
	],
	#category : #'Toplo-Theme-Skins'
}

{ #category : #'event handling' }
ToImageLook >> adaptForegroundIn: anElement withColor: aColor [

	foreColor = aColor ifTrue: [ ^ self ].
	foreColor := aColor.
	anElement
		withInnerFormDo: [ :form |
			| newForm |
			newForm := form collectColors: [ :color | aColor alpha: color alpha ].
			anElement innerImage: newForm ]
		ifNone: [  ]
]

{ #category : #accessing }
ToImageLook >> foregroundFromElement: anElement [

	^ anElement toTheme colorImage
]

{ #category : #accessing }
ToImageLook >> foregroundHoverFromElement: anElement [

	^ self foregroundFromElement: anElement
]

{ #category : #accessing }
ToImageLook >> foregroundPressedFromElement: anElement [

	^ self foregroundFromElement: anElement
]

{ #category : #'event handling' }
ToImageLook >> hoverStateEvent: anEvent [

]

{ #category : #'event handling' }
ToImageLook >> initialStateEvent: anEvent [

	anEvent elementDo: [ :e |
		| c |
		c := self foregroundFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLook >> installStateEvent: anEvent [

	super installStateEvent: anEvent.
	anEvent elementDo: [ :e |
		| c |
		c := self foregroundFromElement: e.
		self adaptForegroundIn: e withColor: c ]
]

{ #category : #'event handling' }
ToImageLook >> pressedStateEvent: anEvent [


]
