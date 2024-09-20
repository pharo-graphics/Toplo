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

{ #category : #'instance creation' }
ToListNode >> newRawSkin [ 

	^ ToListNodeSkin new
]
