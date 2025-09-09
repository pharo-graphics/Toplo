Class {
	#name : #ToMultiSelectPopupManager,
	#superclass : #ToSelectPopupManager,
	#category : #'Toplo-Widget-Select-manager'
}

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

{ #category : #'window handling' }
ToMultiSelectPopupManager >> requestCloseWindowOnEvent: anEvent [
	" don't autoclose if mouse up on a select bar item "

	| target |
	target := anEvent target.
	(target withAllParentsInclude: anchorElement barElement) ifTrue: [
		^ self ].
	super requestCloseWindowOnEvent: anEvent
]
