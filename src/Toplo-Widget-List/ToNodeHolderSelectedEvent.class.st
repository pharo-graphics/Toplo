Class {
	#name : 'ToNodeHolderSelectedEvent',
	#superclass : 'ToNodeHolderEvent',
	#category : 'Toplo-Widget-List-node',
	#package : 'Toplo-Widget-List',
	#tag : 'node'
}

{ #category : 'sending' }
ToNodeHolderSelectedEvent >> sendTo: anObject [

	^ anObject nodeHolderSelectedEvent: self
]
