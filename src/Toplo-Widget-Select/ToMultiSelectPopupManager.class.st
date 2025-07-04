Class {
	#name : #ToMultiSelectPopupManager,
	#superclass : #ToSelectPopupManager,
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #'window handling' }
ToMultiSelectPopupManager >> checkCloseWindowOnPickingEvent: anEvent [
	" don't autoclose if mouse up on a select bar item "

	| target |
	target := anEvent target.
	(anchorElement barElement itemContaining: target) ifNotNil: [ :found |
		^ self ].
	super checkCloseWindowOnPickingEvent: anEvent
]

{ #category : #initialization }
ToMultiSelectPopupManager >> defaultCloseOnPicking [

	^ false
]

{ #category : #initialization }
ToMultiSelectPopupManager >> listElementClass [

	^ ToMultiSelectListElement
]

{ #category : #initialization }
ToMultiSelectPopupManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]
