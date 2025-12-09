Class {
	#name : #ToSelectPopupWindowOpeningStartStep,
	#superclass : #ToAnchoredWindowLayoutStep,
	#instVars : [
		'maxHeightPolicy'
	],
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #accessing }
ToSelectPopupWindowOpeningStartStep >> maxHeightPolicy [

	^ maxHeightPolicy
]

{ #category : #accessing }
ToSelectPopupWindowOpeningStartStep >> maxHeightPolicy: aPopupMaxHeightPolicy [

	maxHeightPolicy := aPopupMaxHeightPolicy
]

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
		  maxHeightPolicy: maxHeightPolicy;
		  yourself
]
