Class {
	#name : #ToStateAnnouncement,
	#superclass : #ToWidgetAnnouncement,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToStateAnnouncement >> state [

	^ state
]

{ #category : #accessing }
ToStateAnnouncement >> state: aWidgetState [

	state := aWidgetState
]
