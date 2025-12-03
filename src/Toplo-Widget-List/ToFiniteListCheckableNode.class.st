Class {
	#name : #ToFiniteListCheckableNode,
	#superclass : #ToFiniteListItemNode,
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #'t - list node' }
ToFiniteListCheckableNode >> clickEventHandlerClass [

	^  ToCheckableNodeSelectionEventHandler
]
