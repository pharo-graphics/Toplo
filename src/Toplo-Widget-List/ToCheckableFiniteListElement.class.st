"
I'm list whose contents is a checkable element (i.e. a list of toggle elements)
"
Class {
	#name : #ToCheckableFiniteListElement,
	#superclass : #ToItemFiniteListElement,
	#traits : 'TToCheckableGroupUser + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupUser classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #accessing }
ToCheckableFiniteListElement >> defaultFakeDataItem [

	^ ToToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToCheckableFiniteListElement >> defaultNodeManagerClass [ 

	^ ToCheckableListNodeManager 
]

{ #category : #initialization }
ToCheckableFiniteListElement >> initialize [

	super initialize.
	self initializeAsCheckableListElement
]
