Class {
	#name : #ToListDoubleClickEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #sending }
ToListDoubleClickEvent >> sendTo: anObject [

	anObject listDoubleClickEvent: self
]

{ #category : #accessing }
ToListDoubleClickEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListDoubleClickEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
