Class {
	#name : #ToMouseUpOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToMouseUpOutsideEvent >> sendTo: anObject [

	anObject mouseUpOutsideEvent: self
]

{ #category : #accessing }
ToMouseUpOutsideEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToMouseUpOutsideEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
