"
I'm list whose contents is a checkable element (i.e. a list of toggle elements)
"
Class {
	#name : #ToCheckableFiniteListElement,
	#superclass : #ToItemFiniteListElement,
	#traits : 'TToCheckableGroupOwner + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupOwner classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - item list - accessing' }
ToCheckableFiniteListElement >> defaultNodeManagerClass [ 

	^ ToCheckableFiniteListNodeManager 
]

{ #category : #initialization }
ToCheckableFiniteListElement >> initialize [

	super initialize.
	self initializeAsCheckableListElement
]
