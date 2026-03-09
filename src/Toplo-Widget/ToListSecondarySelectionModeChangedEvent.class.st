Class {
	#name : #ToListSecondarySelectionModeChangedEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListSecondarySelectionModeChangedEvent >> sendTo: anObject [

	anObject listSecondarySelectionModeChangedEvent: self
]
