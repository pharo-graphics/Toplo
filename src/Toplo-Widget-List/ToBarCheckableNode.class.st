Class {
	#name : #ToBarCheckableNode,
	#superclass : #ToBarItemNode,
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToBarCheckableNode >> checkableElement [ 

	^ self item
]

{ #category : #accessing }
ToBarCheckableNode >> checkableElement: aCheckable [

	self item: aCheckable
]

{ #category : #'t - list node' }
ToBarCheckableNode >> clickEventHandlerClasses [

	^  { ToCheckableNodeSelectionEventHandler } 
]
