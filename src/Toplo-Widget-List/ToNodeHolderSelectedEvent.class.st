Class {
	#name : #ToNodeHolderSelectedEvent,
	#superclass : #ToNodeHolderEvent,
	#category : #'Toplo-Widget-List-node'
}

{ #category : #sending }
ToNodeHolderSelectedEvent >> sendTo: anObject [

	^ anObject nodeHolderSelectedEvent: self
]
