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
	self width: 100.
	self vMatchParent
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
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
