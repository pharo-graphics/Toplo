Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToListNode classTrait + TToAuthorisationRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToListNode >> applyConfiguration [

	super applyConfiguration.
	self hMatchParent.
	self holder initializeNode
]

{ #category : #'t - list node' }
ToListNode >> clickEventHandlerClass [

	^  ToListNodeSelectionEventHandler
]

{ #category : #skin }
ToListNode >> newRawSkin [ 

	^ ToListNodeSkin new
]
