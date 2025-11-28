Class {
	#name : #ToGenericListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #initialization }
ToGenericListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager  
]

{ #category : #sorting }
ToGenericListElement >> sort: aSortBlock [

	self selecter
		updateSelectionAfter: [ self dataAccessor sort: aSortBlock ]
		withDataAccessor: self dataAccessor
]
