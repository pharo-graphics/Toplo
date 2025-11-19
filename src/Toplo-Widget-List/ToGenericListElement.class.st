Class {
	#name : #ToGenericListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToGenericListElement + TToCheckboxBasedSelectionManager',
	#classTraits : 'TToGenericListElement classTrait + TToCheckboxBasedSelectionManager classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]
