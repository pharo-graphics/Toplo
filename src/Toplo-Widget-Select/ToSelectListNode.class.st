Class {
	#name : #ToSelectListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'t - list node' }
ToSelectListNode >> clickEventHandlerClass [ 

	^ ToSelectListNodeSelectionEventHandler
]
