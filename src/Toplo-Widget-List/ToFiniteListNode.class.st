"
I'm a node that contains the elements built from the datasource. See superclass comments.
In addition I'm in bar (a finite list by opposition to infinite). 
"
Class {
	#name : #ToFiniteListNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToFiniteListNode',
	#classTraits : 'TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToFiniteListNode >> initialize [

	super initialize.
	self initializeAsFiniteListNode 

]

{ #category : #skin }
ToFiniteListNode >> newRawSkin [ 

	^ ToFiniteListNodeSkin new
]
