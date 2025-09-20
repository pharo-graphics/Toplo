Class {
	#name : #ToMenuMouseUpOutsideEventFilter,
	#superclass : #ToPopupMouseUpOutsideEventFilter,
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'mouse handlers' }
ToMenuMouseUpOutsideEventFilter >> isOutsideEvent: anEvent [

	| target |
	target := anEvent target.
	" Lookup a possible custom menu item.
	In this case, no mouse outside event to let the
	element of the custom menu item manage its events "
	(target firstInParentChainSatisfying: [ :e |
		 e isKindOf: ToAnchoredWindow ]) ifNotNil: [ :w |
			| foundAnchorElement |
			" example: w can be a ToSelectPopupWindow 
			(A customMenuItem with a ToSelectElement and 
			the anchorElement is the ToSelect)"
			foundAnchorElement := w anchorElement.
			(foundAnchorElement hasAnyInParentChainSatisfying: [ :e |
				 e isKindOf: ToCustomMenuItem ]) ifTrue: [ ^ false ] ].
	^ super isOutsideEvent: anEvent
]
