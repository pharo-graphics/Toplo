Class {
	#name : #ToImageLook,
	#superclass : #ToElementLook,
	#instVars : [
		'foreColor'
	],
	#category : #'Toplo-Theme-Skins-Looks'
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
ToImageLook >> foregroundHoverFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #accessing }
ToImageLook >> foregroundInitialFromElement: anElement [

	^ anElement toTheme colorImage
]

{ #category : #accessing }
ToImageLook >> foregroundPressedFromElement: anElement [

	^ self foregroundInitialFromElement: anElement
]

{ #category : #'event handling' }
ToImageLook >> hoverStateEvent: anEvent [

]

{ #category : #'event handling' }
ToImageLook >> initialStateEvent: anEvent [


]

{ #category : #'event handling' }
ToImageLook >> installStateEvent: anEvent [


]

{ #category : #'event handling' }
ToImageLook >> pressedStateEvent: anEvent [


]
