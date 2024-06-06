Class {
	#name : #ToListPrimarySelectionChangeUnanimityRequestEvent,
	#superclass : #ToUnanimityRequestEvent,
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #sending }
ToListPrimarySelectionChangeUnanimityRequestEvent >> sendTo: anObject [

	anObject listPrimarySelectionChangeUnanimityRequestEvent: self
]
