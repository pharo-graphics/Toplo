Class {
	#name : #ToSelectPopupWindowMaxHeightStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #running }
ToSelectPopupWindowMaxHeightStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	" at least 2 policies, one with a fixed maxHeight and the second with 
	a computed maxHeight according to the available space in the anchorRoot"
	^ aWindow manager maxHeightPolicy
		  nextLayoutStepFor: aWindow
		  from: self
]
