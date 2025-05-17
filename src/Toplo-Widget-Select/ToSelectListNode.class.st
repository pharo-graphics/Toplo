Class {
	#name : #ToSelectListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'t - list node' }
ToSelectListNode >> clickEventHandlerClass [ 

	^ ToSelectListNodeSelectionEventHandler
]
