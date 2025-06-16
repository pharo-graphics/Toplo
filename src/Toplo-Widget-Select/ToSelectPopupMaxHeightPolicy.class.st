Class {
	#name : #ToSelectPopupMaxHeightPolicy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #layout }
ToSelectPopupMaxHeightPolicy >> nextLayoutStepFor: aWindow from: aLayoutStep [

	^ self subclassResponsibility 
]
