Class {
	#name : 'ToNodeHolderDeselectedEvent',
	#superclass : 'ToNodeHolderEvent',
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 'sending' }
ToNodeHolderDeselectedEvent >> sendTo: anObject [

	^ anObject nodeHolderDeselectedEvent: self
]
