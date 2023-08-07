Class {
	#name : #ToExitStateEvent,
	#superclass : #ToStateEvent,
	#instVars : [
		'nextState'
	],
	#category : #'Toplo-Core'
}

{ #category : #testing }
ToExitStateEvent class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
ToExitStateEvent >> nextState [

	^ nextState
]

{ #category : #accessing }
ToExitStateEvent >> nextState: aState [

	nextState := aState
]
