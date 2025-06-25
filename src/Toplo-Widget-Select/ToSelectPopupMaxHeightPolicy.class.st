Class {
	#name : #ToSelectPopupMaxHeightPolicy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-manager'
}

{ #category : #layout }
ToSelectPopupMaxHeightPolicy >> nextLayoutStepFor: aWindow from: aLayoutStep [

	^ self subclassResponsibility 
]
