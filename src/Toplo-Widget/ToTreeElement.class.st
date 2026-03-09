Class {
	#name : #ToTreeElement,
	#superclass : #ToBasicTreeElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-Tree'
}

{ #category : #accessing }
ToTreeElement >> childrenGetter: aValuable [

	self nodeManager childrenGetter: aValuable 
]

{ #category : #initialization }
ToTreeElement >> defaultNodeManagerClass [ 

	^ ToTreeGenericNodeManager
]
