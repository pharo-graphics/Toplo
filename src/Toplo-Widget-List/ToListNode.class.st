Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToListNode classTrait + TToAuthorisationRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToListNode >> applyWidgetConfiguration [

	| l |
	super applyWidgetConfiguration.
	l := self holder listElement.
	l isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	self vFitContent.
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
