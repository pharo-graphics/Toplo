Class {
	#name : #ToListDoubleClickOnNodeEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #sending }
ToListDoubleClickOnNodeEvent >> sendTo: anObject [

	anObject listDoubleClickOnNodeEvent: self
]

{ #category : #accessing }
ToListDoubleClickOnNodeEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListDoubleClickOnNodeEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
