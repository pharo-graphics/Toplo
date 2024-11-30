Class {
	#name : #ToMultiSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'window handling' }
ToMultiSelectPopupWindowManager >> checkAutoCloseWindowOnMouseUp: anEvent [
	" don't autoclose if mouse up on a select bar item "

	(element barElement itemContaining: anEvent target) ifNotNil: [
		:found | ^ self ].
	super checkAutoCloseWindowOnMouseUp: anEvent
]

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
