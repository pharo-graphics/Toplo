Class {
	#name : #ToInlineWindowElement,
	#superclass : #ToElement,
	#traits : 'TToAnchoredWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait',
	#category : #'Toplo-Core-Window'
}

{ #category : #layout }
ToInlineWindowElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToInlineWindowElement >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self measureWindowOnEvent: self lastPopupEvent
]

{ #category : #'t - inline window element - accessing' }
ToInlineWindowElement >> root [ 

	^ self 
]
