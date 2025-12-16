"
I'm a list managed by a generic node manager (this manager is based of blocks for holder, node container et node building).
"
Class {
	#name : #ToGenericListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]
