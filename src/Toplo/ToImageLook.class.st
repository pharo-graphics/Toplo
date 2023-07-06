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

{ #category : #'event handling' }
ToImageLook >> hoverLookEvent: anEvent [

]

{ #category : #'event handling' }
ToImageLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToImageLook >> installLookEvent: anEvent [


]

{ #category : #'event handling' }
ToImageLook >> pressedLookEvent: anEvent [


]
