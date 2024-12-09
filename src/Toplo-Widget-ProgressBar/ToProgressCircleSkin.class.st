Class {
	#name : #ToProgressCircleSkin,
	#superclass : #ToBasicSkin,
	#category : #'Toplo-Widget-ProgressBar'
}

{ #category : #'event handling' }
ToProgressCircleSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e hasLabel ifTrue: [
			e label text attributes: { (BlTextForegroundAttribute paint:
					 (e valueOfTokenNamed: #'color-text')) }.
			e label textChanged ].

		e remainingBar border:(BlBorder paint:
			(e valueOfTokenNamed: #'color-bg-container-disabled')width: 4)]
]
