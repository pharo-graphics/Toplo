Class {
	#name : #ToMultiSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'window handling' }
ToMultiSelectPopupWindowManager >> checkCloseWindowOnPickingEvent: anEvent [
	" don't autoclose if mouse up on a select bar item "

	| target |
	target := anEvent target.
	(element barElement itemContaining: target) ifNotNil: [ :found |
		^ self ].
	super checkCloseWindowOnPickingEvent: anEvent
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
