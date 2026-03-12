Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableListElement',
	#classTraits : 'TToCheckableListElement classTrait',
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
