Class {
	#name : #ToCheckableNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToCheckableNode >> checkableElement [ 

	^ self item
]

{ #category : #accessing }
ToCheckableNode >> checkableElement: aCheckable [

	self item: aCheckable
]

{ #category : #'t - list node' }
ToCheckableNode >> clickEventHandlerClasses [

	^  { ToCheckableNodeSelectionEventHandler } 
]
