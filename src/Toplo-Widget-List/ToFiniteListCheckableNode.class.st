Class {
	#name : #ToFiniteListCheckableNode,
	#superclass : #ToFiniteListItemNode,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'t - list node' }
ToFiniteListCheckableNode >> clickEventHandlerClass [

	^  ToCheckableNodeSelectionEventHandler
]
