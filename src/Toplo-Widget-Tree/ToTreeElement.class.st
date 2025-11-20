Class {
	#name : #ToTreeElement,
	#superclass : #ToAbstractTreeElement,
	#traits : 'TToGenericListElement + TToCheckableSelectionManager',
	#classTraits : 'TToGenericListElement classTrait + TToCheckableSelectionManager classTrait',
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeElement >> childrenGetter: aValuable [

	self nodeManager childrenGetter: aValuable 
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [ 

	^ ToGenericTreeNodeManager
]
