Class {
	#name : #ToListNodeHolderSelectedEvent,
	#superclass : #ToListNodeHolderEvent,
	#category : 'Toplo-Widget-List-Node'
}

{ #category : #sending }
ToListNodeHolderSelectedEvent >> sendTo: anObject [

	^ anObject listNodeHolderSelectedEvent: self
]
