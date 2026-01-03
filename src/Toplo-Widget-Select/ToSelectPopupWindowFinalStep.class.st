Class {
	#name : #ToSelectPopupWindowFinalStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #running }
ToSelectPopupWindowFinalStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	"it may be required to update the selection"
	aWindow manager listElement requestUpdateAllSelections.
	^ nil
]

{ #category : #running }
ToSelectPopupWindowFinalStep >> onSetInAnchoredWindow: anAnchoredWindow [

	anAnchoredWindow visibility: BlVisibility visible.
	super onSetInAnchoredWindow: anAnchoredWindow
]
