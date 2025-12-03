Class {
	#name : #ToFiniteListNode,
	#superclass : #ToAbstractListNode,
	#traits : 'TToFiniteListNode',
	#classTraits : 'TToFiniteListNode classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFiniteListNode >> applyConfiguration [

	super applyConfiguration.
	self holder initializeNode
]

{ #category : #'t - list node' }
ToFiniteListNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #initialization }
ToFiniteListNode >> initialize [

	super initialize.
	self initializeAsBarNode 

]

{ #category : #skin }
ToFiniteListNode >> newRawSkin [ 

	^ ToBarNodeSkin new
]
