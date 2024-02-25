Class {
	#name : #ToListPrimarySelectionDirtyEvent,
	#superclass : #ToListElementEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionDirtyEvent >> sendTo: anObject [

	anObject listPrimarySelectionDirtyEvent: self
]
