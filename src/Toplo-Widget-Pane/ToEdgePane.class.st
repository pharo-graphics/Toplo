Class {
	#name : #ToEdgePane,
	#superclass : #ToPane,
	#traits : 'TToAnchoredWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #initialization }
ToEdgePane >> initialize [ 

	super initialize.
	self withNullSkin.
	self extent: 100 asPoint.
	self background: Color lightGray
]

{ #category : #layout }
ToEdgePane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToEdgePane >> onMeasure: anExtentMeasurementSpec [

	self onMeasure: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec.


]
