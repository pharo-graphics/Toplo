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

{ #category : #enumerating }
ToAnchoredWindow >> inheritedThemeHolderDo: aBlock [

	^ self anchorElement
		  ifNil: [ super inheritedThemeHolderDo: aBlock ]
		  ifNotNil: [ aBlock value: self anchorElement ]
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

	self measureWithExtentMeasurementSpec: anExtentMeasurementSpec onEvent: self lastPopupEvent.
	super onMeasure: anExtentMeasurementSpec.


]
