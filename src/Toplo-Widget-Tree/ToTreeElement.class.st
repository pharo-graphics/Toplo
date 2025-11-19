Class {
	#name : #ToTreeElement,
	#superclass : #ToAbstractTreeElement,
	#traits : 'TToGenericListElement + TToCheckboxBasedSelectionManager',
	#classTraits : 'TToGenericListElement classTrait + TToCheckboxBasedSelectionManager classTrait',
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
