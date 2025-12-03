"
I'm list whose contents is a checkable element (i.e. a list of toggle elements)
"
Class {
	#name : #ToCheckableBarElement,
	#superclass : #ToItemBarElement,
	#traits : 'TToCheckableGroupOwner + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupOwner classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - item list - accessing' }
ToCheckableBarElement >> defaultNodeManagerClass [ 

	^ ToCheckableBarNodeManager 
]

{ #category : #initialization }
ToCheckableBarElement >> initialize [

	super initialize.
	self initializeAsCheckableListElement
]
