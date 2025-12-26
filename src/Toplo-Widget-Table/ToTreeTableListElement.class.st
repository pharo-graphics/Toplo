Class {
	#name : #ToTreeTableListElement,
	#superclass : #ToTreeElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTreeTableListElement >> defaultNodeManagerClass [

	^ ToTreeTableRowNodeManager
]

{ #category : #initialization }
ToTreeTableListElement >> initialize [

	super initialize.
	self initializeAsTableListElement 
]

{ #category : #skin }
ToTreeTableListElement >> newRawSkin [ 

	^ ToTableListElementSkin new
]
