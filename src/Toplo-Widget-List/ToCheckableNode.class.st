Class {
	#name : #ToCheckableNode,
	#superclass : #ToItemNode,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #'as yet unclassified' }
ToCheckableNode >> checkableElement [ 

	^ self item
]

{ #category : #'as yet unclassified' }
ToCheckableNode >> checkableElement: aCheckable [

	self item: aCheckable
]

{ #category : #'as yet unclassified' }
ToCheckableNode >> clickEventHandlerClasses [

	^  { ToCheckableNodeSelectionEventHandler } 
]

{ #category : #skin }
ToCheckableNode >> newRawSkin [ 

	^ ToSegmentedNodeSkin new
]
