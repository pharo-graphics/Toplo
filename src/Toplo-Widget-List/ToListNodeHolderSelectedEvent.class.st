Class {
	#name : 'ToListNodeHolderSelectedEvent',
	#superclass : 'ToListNodeHolderEvent',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'sending' }
ToListNodeHolderSelectedEvent >> sendTo: anObject [

	^ anObject listNodeHolderSelectedEvent: self
]
