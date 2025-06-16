Class {
	#name : #ToSelectPopupWindowOpeningStartStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #running }
ToSelectPopupWindowOpeningStartStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	aWindow visibility: BlVisibility hidden.
	aWindow
		positionOnEvent: anEvent
		context: aBlElementBoundsUpdateContext.

	" now temporarily change the layout to vFitContent to 
	force the measurement of the listElement and of aWindow.
	eventually, this will be  changed in next step "
	aWindow manager listElement vFitContent.
	aWindow vFitContent.

	^ ToSelectPopupWindowMaxHeightStep new
]
