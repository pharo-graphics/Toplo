Class {
	#name : #ToProgressBarSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-ProgressBar-ProgressBar'
}

{ #category : #'event handling' }
ToProgressBarSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e hasLabel ifTrue: [
			e label text attributes:
				{ (BlTextForegroundAttribute paint:(e valueOfTokenNamed: #'color-text')) }.
			e label textChanged.
			e label padding: (BlInsets left: 10) ].
		
		e hasIcon ifTrue: [ e icon padding: (BlInsets left: 10) ].
		
		e progressBar background: (e valueOfTokenNamed: #'color-primary').
		e remainingBar background: (e valueOfTokenNamed: #'color-bg-container-disabled').
		
		e progressBar height: 6.
		e remainingBar height: 6.
		
		e progressBar geometry: (BlRoundedRectangleGeometry cornerRadius: 100).
		e remainingBar geometry: (BlRoundedRectangleGeometry cornerRadius: 100)]
]
