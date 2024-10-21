Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToListNode classTrait + TToAuthorisationRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
ToListNode >> clickEventHandlerClasses [

	^ self holder listElement isMultipleSelection
		  ifTrue: [ { ToListNodeMultiSelectionClickEventHandler } ]
		  ifFalse: [ { ToListNodeSingleSelectionClickEventHandler } ]
]

{ #category : #skin }
ToListNode >> installRawStyle [

	super installRawStyle.
	self outskirts: BlOutskirts inside.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'list-node-padding-H')
			 vertical: (self valueOfTokenNamed: #'list-node-padding-V'))
]
