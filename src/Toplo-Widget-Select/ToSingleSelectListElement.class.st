Class {
	#name : #ToSingleSelectListElement,
	#superclass : #ToSelectListElement,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #initialization }
ToSingleSelectListElement >> defaultEventHandler [

	^ ToSingleSelectListElementEventHandler new
]

{ #category : #initialization }
ToSingleSelectListElement >> defaultNodeManagerClass [

	^ ToSelectListNodeManager  
]

{ #category : #initialization }
ToSingleSelectListElement >> listNodeClass [

	^ ToSelectListNode
]
