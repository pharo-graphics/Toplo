Class {
	#name : #ToTreeElement,
	#superclass : #ToAbstractTreeElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [ 

	^ ToGenericTreeNodeManager
]
