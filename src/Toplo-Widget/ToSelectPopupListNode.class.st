Class {
	#name : #ToSelectPopupListNode,
	#superclass : #ToBasicListNode,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'t - list node' }
ToSelectPopupListNode >> clickEventHandlerClass [ 

	^ ToSelectPopupListNodeSelectionEventHandler
]
