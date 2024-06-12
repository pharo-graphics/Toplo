Class {
	#name : #ToListNode,
	#superclass : #ToAbstractListNode,
	#classTraits : 'TToEnableable classTrait + TToListNode classTrait + TToUnanimityRequestTarget classTrait',
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - list node' }
ToListNode >> clickEventHandlerClasses [

	^ self holder listElement isMultipleSelection
		  ifTrue: [ { ToListNodeMultiSelectionClickEventHandler } ]
		  ifFalse: [ { ToListNodeSingleSelectionClickEventHandler } ]
]

{ #category : #'instance creation' }
ToListNode >> newEventHandler [

	^ ToListNodeEventHandler new
]
