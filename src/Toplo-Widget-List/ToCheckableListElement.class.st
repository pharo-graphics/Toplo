Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupUser + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupUser classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToCheckableListElement >> defaultNodeManagerClass [ 

	^ ToCheckableListNodeManager
]

{ #category : #initialization }
ToCheckableListElement >> initialize [ 

	super initialize.
	self initializeAsCheckableListElement
]
