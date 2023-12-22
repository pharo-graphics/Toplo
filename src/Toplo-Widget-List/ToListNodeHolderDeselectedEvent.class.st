Class {
	#name : 'ToListNodeHolderDeselectedEvent',
	#superclass : 'ToListNodeHolderEvent',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'sending' }
ToListNodeHolderDeselectedEvent >> sendTo: anObject [

	^ anObject listNodeHolderDeselectedEvent: self
]
