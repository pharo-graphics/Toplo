Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#traits : 'TToAnchoredWindowElement + TToRelayoutableWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToRelayoutableWindowElement classTrait',
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> checkOutsideEvent: aBoolean [

	self manager checkOutsideEvent: aBoolean
]

{ #category : #accessing }
ToAnchoredWindow >> checkPickOutside: aBoolean [

	self
		deprecated: 'Use #checkOutsideEvent instead'
		transformWith:
		'`@rcvr checkPickOutside: `@arg'
		-> '`@rcvr checkOutsideEvent: `@arg'.

	self checkOutsideEvent: aBoolean
]

{ #category : #testing }
ToAnchoredWindow >> isActionRunnableAfter: aTimeStamp [

	^ self manager isActionRunnableAfter:
		  aTimeStamp
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
