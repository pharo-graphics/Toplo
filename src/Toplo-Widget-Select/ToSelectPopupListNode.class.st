Class {
	#name : #ToSelectPopupListNode,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'t - list node' }
ToSelectPopupListNode >> clickEventHandlerClass [ 

	^ ToSelectPopupListNodeSelectionEventHandler
]
