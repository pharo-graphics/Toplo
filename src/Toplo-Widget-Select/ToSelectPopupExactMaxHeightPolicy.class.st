Class {
	#name : #ToSelectPopupExactMaxHeightPolicy,
	#superclass : #ToSelectPopupMaxHeightPolicy,
	#instVars : [
		'maxHeight'
	],
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #accessing }
ToSelectPopupExactMaxHeightPolicy >> maxHeight [

	^ maxHeight ifNil: [ maxHeight := 600 ]
]

{ #category : #accessing }
ToSelectPopupExactMaxHeightPolicy >> maxHeight: aNumber [

	maxHeight := aNumber
]

{ #category : #layout }
ToSelectPopupExactMaxHeightPolicy >> nextLayoutStepFor: aWindow from: aLayoutStep [
	" *** notice: the innerElement maxHeght *** must be *** 
		>= innerElement height and consistent with listElement height - padding height
	If not, it can work but with a possible gap with the listElement height - padding height 
	"

	| listElement |
	listElement := aWindow manager listElement.
	listElement innerElement maxHeight: maxHeight.
	^ ToSelectPopupWindowVFitContentStep new
]
