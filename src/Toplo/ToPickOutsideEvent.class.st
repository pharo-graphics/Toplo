Class {
	#name : #ToPickOutsideEvent,
	#superclass : #BlEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToPickOutsideEvent >> sendTo: anObject [

	anObject pickOutsideEvent: self
]

{ #category : #accessing }
ToPickOutsideEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToPickOutsideEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
