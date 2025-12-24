"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToBasicListElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableRowNodeManager
]

{ #category : #initialization }
ToTableListElement >> initialize [

	super initialize.
	self initializeAsTableListElement 
]

{ #category : #skin }
ToTableListElement >> newRawSkin [ 

	^ ToTableListElementSkin new
]
