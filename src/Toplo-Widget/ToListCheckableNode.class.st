Class {
	#name : #ToListCheckableNode,
	#superclass : #ToListItemNode,
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - list node' }
ToListCheckableNode >> clickEventHandlerClass [

	^  ToCheckableNodeSelectionEventHandler
]
