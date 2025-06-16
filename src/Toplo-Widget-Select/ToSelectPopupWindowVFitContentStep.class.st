Class {
	#name : #ToSelectPopupWindowVFitContentStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #running }
ToSelectPopupWindowVFitContentStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	| listElement |
	listElement := aWindow manager listElement.
	listElement vFitContent.
	aWindow vFitContent.
	^ ToSelectPopupWindowFinalStep new
]
