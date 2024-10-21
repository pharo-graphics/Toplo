Class {
	#name : #ToMultiSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'api - hooks' }
ToMultiSelectPopupWindowManager >> defaultListElementEventHandler [ 

	^ ToMultiSelectListElementEventHandler new
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> listElementClass [

	^ ToMultiSelectListElement
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]

{ #category : #'api - hooks' }
ToMultiSelectPopupWindowManager >> nodeHolderClass [

	^ ToMultiSelectListNodeHolder
]
