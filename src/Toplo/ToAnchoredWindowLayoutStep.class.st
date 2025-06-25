Class {
	#name : #ToAnchoredWindowLayoutStep,
	#superclass : #Object,
	#category : #'Toplo-Core-Window'
}

{ #category : #running }
ToAnchoredWindowLayoutStep >> nextStepFor: aWindow onEvent: anEvent onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self subclassResponsibility 
]

{ #category : #running }
ToAnchoredWindowLayoutStep >> onSetInAnchoredWindow: anAnchoredWindow [

	anAnchoredWindow requestLayout
]
