Class {
	#name : #ToGenericListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToGenericListElement + TToCheckableSelectionManager',
	#classTraits : 'TToGenericListElement classTrait + TToCheckableSelectionManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]
