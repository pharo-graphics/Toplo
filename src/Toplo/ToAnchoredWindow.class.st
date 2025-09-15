Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#traits : 'TToAnchoredWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait',
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> checkPickOutside: aBoolean [

	self manager checkPickOutside: aBoolean
]

{ #category : #layout }
ToAnchoredWindow >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToAnchoredWindow >> onMeasure: anExtentMeasurementSpec [

	self onMeasure: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec.


]

{ #category : #'api - displaying' }
ToAnchoredWindow >> toThemeInstalled [

	| lt |
	self anchorElement ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]
