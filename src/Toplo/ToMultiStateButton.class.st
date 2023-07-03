Class {
	#name : #ToMultiStateButton,
	#superclass : #ToButton,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToMultiStateButton >> initialize [ 

	super initialize.
	self whenClickedDo: [ self switchToNextState ]
]
