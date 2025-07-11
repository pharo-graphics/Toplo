Class {
	#name : #ToTreeElement,
	#superclass : #ToAbstractTreeElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
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
