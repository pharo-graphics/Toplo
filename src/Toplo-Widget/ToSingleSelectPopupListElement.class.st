Class {
	#name : #ToSingleSelectPopupListElement,
	#superclass : #ToSelectPopupListElement,
	#category : #'Toplo-Widget-Select'
}

{ #category : #initialization }
ToSingleSelectPopupListElement >> defaultEventHandler [

	^ ToSingleSelectPopupListElementEventHandler new
]

{ #category : #initialization }
ToSingleSelectPopupListElement >> listNodeClass [

	^ ToSelectPopupListNode
]
