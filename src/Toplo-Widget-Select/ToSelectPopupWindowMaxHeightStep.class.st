Class {
	#name : #ToSelectPopupWindowMaxHeightStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#instVars : [
		'maxHeightPolicy'
	],
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #accessing }
ToSelectPopupWindowMaxHeightStep >> maxHeightPolicy [

	^ maxHeightPolicy
]

{ #category : #accessing }
ToSelectPopupWindowMaxHeightStep >> maxHeightPolicy: aPopupMaxHeightPolicy [

	maxHeightPolicy := aPopupMaxHeightPolicy
]

{ #category : #running }
ToSelectPopupWindowMaxHeightStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [
	" if there is not enough place then turn as a scrollable menu container "

	" at least 2 policies, one with a fixed maxHeight and the second with 
	a computed maxHeight according to the available space in the anchorRoot"
	^ maxHeightPolicy
		  nextLayoutStepFor: aWindow
		  from: self
]
