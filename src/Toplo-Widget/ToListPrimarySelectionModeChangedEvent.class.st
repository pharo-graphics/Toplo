Class {
	#name : #ToListPrimarySelectionModeChangedEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List'
}

{ #category : #sending }
ToListPrimarySelectionModeChangedEvent >> sendTo: anObject [

	anObject listPrimarySelectionModeChangedEvent: self
]
