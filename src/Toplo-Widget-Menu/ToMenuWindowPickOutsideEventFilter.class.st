Class {
	#name : #ToMenuWindowPickOutsideEventFilter,
	#superclass : #ToPopupPickOutsideEventFilter,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #private }
ToMenuWindowPickOutsideEventFilter >> isPickedOutsideEvent: anEvent [
	" return true if the event is considered as a pick outside event "

	| target |
	target := anEvent target.
	(target firstInParentChainSatisfying: [ :e |
		 e isKindOf: ToPopupWindow ]) ifNotNil: [ :w | target := w element ].
	(target hasAnyInParentChainSatisfying: [ :e |
		 e isKindOf: ToMenuItemElement ]) ifTrue: [ ^ false ].
	^ super isPickedOutsideEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMenuWindowPickOutsideEventFilter >> onMouseUpEvent: anEvent [
	" 
	do nothing if the original event target is the element with popup or
	if the original event target is the popup window 
	"

	" Clicking on a menu item that is not a top item 
	should cancel the menubar auto-open"

	self element menuBarDo: [ :mb |
		(anEvent target firstInParentChainSatisfying: [ :e |
			 e isKindOf: ToMenuItemElement ]) ifNotNil: [ :w |
			w isTopMenu ifFalse: [ mb cancelAutoOpen ] ] ].
	super onMouseUpEvent: anEvent
]
