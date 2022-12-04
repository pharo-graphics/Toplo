Class {
	#name : #ToExitStateAnnouncement,
	#superclass : #ToWidgetAnnouncement,
	#instVars : [
		'nextState'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToExitStateAnnouncement >> nextState [

	^ nextState
]

{ #category : #accessing }
ToExitStateAnnouncement >> nextState: aState [

	nextState := aState
]
