Class {
	#name : #ToListClickOnNodeEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'sourceEvent'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #sending }
ToListClickOnNodeEvent >> sendTo: anObject [

	anObject listClickOnNodeEvent: self
]

{ #category : #accessing }
ToListClickOnNodeEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToListClickOnNodeEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
