Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToListNode classTrait + TToAuthorisationRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToListNode >> applyWidgetConfiguration [

	super applyWidgetConfiguration.
	self constraintsDo: [ :c |
		| l |
		l := self holder listElement.
		l isHorizontal
			ifTrue: [ c horizontal fitContent ]
			ifFalse: [ c horizontal matchParent ].
		c vertical fitContent ].
	self holder initializeNode
]

{ #category : #'t - list node' }
ToListNode >> clickEventHandlerClasses [

	^ self holder listElement isMultipleSelection
		  ifTrue: [ { ToListNodeMultiSelectionClickEventHandler } ]
		  ifFalse: [ { ToListNodeSingleSelectionClickEventHandler } ]
]

{ #category : #skin }
ToListNode >> newRawSkin [ 

	^ ToListNodeSkin new
]
