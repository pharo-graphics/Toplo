Class {
	#name : #ToSelectPopupListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'t - list node' }
ToSelectPopupListNode >> clickEventHandlerClass [ 

	^ ToSelectPopupListNodeSelectionEventHandler
]
