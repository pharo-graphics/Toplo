Class {
	#name : 'ToNodeHolderDeselectedEvent',
	#superclass : 'ToNodeHolderEvent',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'sending' }
ToNodeHolderDeselectedEvent >> sendTo: anObject [

	^ anObject nodeHolderDeselectedEvent: self
]
