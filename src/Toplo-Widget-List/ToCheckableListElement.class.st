Class {
	#name : #ToCheckableListElement,
	#superclass : #ToItemListElement,
	#traits : 'TToCheckableGroupUser + TToCheckableListElement',
	#classTraits : 'TToCheckableGroupUser classTrait + TToCheckableListElement classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #'t - finite list element - fake container' }
ToCheckableListElement >> defaultFakeDataItem [

	^ ToToggleButton new
		  labelText: 'X';
		  yourself
]

{ #category : #initialization }
ToCheckableListElement >> defaultNodeManagerClass [ 

	^ ToCheckableListNodeManager
]

{ #category : #initialization }
ToCheckableListElement >> initialize [ 

	super initialize.
	self initializeAsCheckableListElement
]
