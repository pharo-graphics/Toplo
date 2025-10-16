Class {
	#name : #ToMultiSelectPopupManager,
	#superclass : #ToSelectPopupManager,
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #'event handling' }
ToMultiSelectPopupManager >> isOpeningOrClosingEvent: anEvent [

	| target |
	target := anEvent target.
	(target = anchorElement barElement innerElement or: [
			 target = anchorElement barTrackElement or: [
					 target withAllParents anySatisfy: [ :p |
						 p = anchorElement iconContainer ] ] ]) ifFalse: [ ^ false ].
	^ true
]

{ #category : #initialization }
ToMultiSelectPopupManager >> listElementClass [

	^ ToMultiSelectListElement
]

{ #category : #'event handling' }
ToMultiSelectPopupManager >> mouseUpEvent: anEvent [

	(self isOpeningOrClosingEvent: anEvent) ifFalse: [ ^ self ].
	super mouseUpEvent: anEvent
]

{ #category : #initialization }
ToMultiSelectPopupManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]

{ #category : #'event handling' }
ToMultiSelectPopupManager >> popupEvent: anEvent [

	(self isOpeningOrClosingEvent: anEvent) ifFalse: [ ^ self ].
	super popupEvent: anEvent
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
