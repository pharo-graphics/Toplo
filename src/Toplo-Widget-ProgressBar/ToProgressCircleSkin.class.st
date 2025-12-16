Class {
	#name : #ToProgressCircleSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-ProgressBar-ProgressCircle'
}

{ #category : #'event handling' }
ToProgressCircleSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e hasLabel ifTrue: [
					e label text attributes: { (BlTextForegroundAttribute paint:
							 (e valueOfTokenNamed: #'color-text')) }.
					e label textChanged ].

			e
				addTokenNamed: #progressCircleRemainingBarBackground
				withValue: (e valueOfTokenNamed: #'color-bg-container-disabled').
			e
				addTokenNamed: #progressCircleProgressBarBackground
				withValue: (e valueOfTokenNamed: #'color-primary') ]
]
