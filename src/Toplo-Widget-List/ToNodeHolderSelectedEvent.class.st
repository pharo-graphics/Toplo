Class {
	#name : 'ToNodeHolderSelectedEvent',
	#superclass : 'ToNodeHolderEvent',
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'sending' }
ToNodeHolderSelectedEvent >> sendTo: anObject [

	^ anObject nodeHolderSelectedEvent: self
]
