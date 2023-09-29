Class {
	#name : #ToNodeHolderDeselectedEvent,
	#superclass : #ToNodeHolderEvent,
	#category : #'Toplo-Widget-List-node'
}

{ #category : #sending }
ToNodeHolderDeselectedEvent >> sendTo: anObject [

	^ anObject nodeHolderDeselectedEvent: self
]
