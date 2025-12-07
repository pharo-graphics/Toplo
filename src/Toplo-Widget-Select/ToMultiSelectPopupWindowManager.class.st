Class {
	#name : #ToMultiSelectPopupWindowManager,
	#superclass : #ToSelectPopupWindowManager,
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #'event handling' }
ToMultiSelectPopupWindowManager >> isOpeningOrClosingEvent: anEvent [

	| target |
	target := anEvent target.
	^ target = anchorElement barInnerElement or: [
			  target = anchorElement barTrackElement or: [
				  target anyInParentsSatisfy: [ :p |
					  p = anchorElement endContainer ] ] ]
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> listElementClass [

	^ ToMultiSelectPopupListElement
]

{ #category : #'event handling' }
ToMultiSelectPopupWindowManager >> mouseUpEvent: anEvent [

	(self isOpeningOrClosingEvent: anEvent) ifFalse: [ ^ self ].
	super mouseUpEvent: anEvent
]

{ #category : #initialization }
ToMultiSelectPopupWindowManager >> newListElement [

	| newListElement |
	newListElement := super newListElement.
	newListElement primarySelectionMode multiple: true.
	^ newListElement
]

{ #category : #'window handling' }
ToMultiSelectPopupWindowManager >> popupEvent: anEvent [

	anEvent ifNotNil: [
		(self isOpeningOrClosingEvent: anEvent) ifFalse: [ ^ self ] ].
	super popupEvent: anEvent
]

{ #category : #'window handling' }
ToMultiSelectPopupWindowManager >> requestCloseWindowOnEvent: anEvent [
	" don't autoclose if mouse up on a select bar item "

	| target |
	target := anEvent target.
	(target withAllParentsInclude: anchorElement barElement) ifTrue: [
		^ self ].
	super requestCloseWindowOnEvent: anEvent
]
