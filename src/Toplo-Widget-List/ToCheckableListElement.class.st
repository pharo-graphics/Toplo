Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupOwner + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupOwner classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - item bar element - accessing' }
ToCheckableListElement >> defaultNodeManagerClass [ 

	^ ToCheckableListNodeManager
]

{ #category : #initialization }
ToCheckableListElement >> initialize [ 

	super initialize.
	self initializeAsCheckableListElement
]
