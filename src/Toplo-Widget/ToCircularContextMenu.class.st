Class {
	#name : #ToCircularContextMenu,
	#superclass : #ToCircularMenuPane,
	#traits : 'TToAnchoredWindowElement + TToRelayoutableWindowElement + TToMenuWindowModel',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToRelayoutableWindowElement classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Circular'
}

{ #category : #'t - menu window model' }
ToCircularContextMenu >> closeWindow [

	self close
]

{ #category : #'t - menu window model' }
ToCircularContextMenu >> isTopMenu [

	^ true
]

{ #category : #'t - menu window model' }
ToCircularContextMenu >> menuWindow [

	^ self 
]

{ #category : #layout }
ToCircularContextMenu >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToCircularContextMenu >> onMeasure: anExtentMeasurementSpec [

	self measureWithExtentMeasurementSpec: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec
]
