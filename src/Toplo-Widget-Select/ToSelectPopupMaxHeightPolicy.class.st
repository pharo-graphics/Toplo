Class {
	#name : #ToSelectPopupMaxHeightPolicy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-PopupWindow'
}

{ #category : #layout }
ToSelectPopupMaxHeightPolicy >> nextLayoutStepFor: aWindow from: aLayoutStep [

	^ self subclassResponsibility 
]
