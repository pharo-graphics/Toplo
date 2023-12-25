Class {
	#name : #ToListNodeHolderDeselectedEvent,
	#superclass : #ToListNodeHolderEvent,
	#category : 'Toplo-Widget-List-Node'
}

{ #category : #sending }
ToListNodeHolderDeselectedEvent >> sendTo: anObject [

	^ anObject listNodeHolderDeselectedEvent: self
]
