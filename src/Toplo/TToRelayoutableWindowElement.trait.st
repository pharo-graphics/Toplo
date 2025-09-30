Trait {
	#name : #TToRelayoutableWindowElement,
	#instVars : [
		'lastPopupEvent',
		'layoutStep'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext [

	self layoutStep ifNotNil: [ :ls |
			self layoutStep: (ls
					 nextStepFor: self
					 onEvent: self lastPopupEvent
					 onLayout: aBounds
					 context: aBlElementBoundsUpdateContext) ]
]

{ #category : #'t - relayoutable window element - accessing' }
TToRelayoutableWindowElement >> correctedPositionAccordingToAnchorRoot [

	^ self measuredPosition
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> lastPopupEvent [

	^ lastPopupEvent
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> lastPopupEvent: anEvent [

	lastPopupEvent := anEvent
]

{ #category : #'t - relayoutable window element - accessing' }
TToRelayoutableWindowElement >> layoutStep [

	^ layoutStep 
]

{ #category : #'t - relayoutable window element - accessing' }
TToRelayoutableWindowElement >> layoutStep: aLayoutStep [

	layoutStep := aLayoutStep.
	aLayoutStep ifNil: [ ^ self ].
	aLayoutStep onSetInAnchoredWindow: self
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> newStartLayoutStep [ 

	^ ToAnchoredWindowOpeningStartStep new
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> onMeasure: anExtentMeasurementSpec onEvent: anEvent [

	self manager ifNil: [ ^ self ].
	self manager onMeasure: anExtentMeasurementSpec onEvent: anEvent
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> positionOnEvent: anEvent context: aBlElementBoundsUpdateContext [

	self manager ifNil: [ ^ self ].
	self manager positionWindowOnEvent: anEvent context: aBlElementBoundsUpdateContext
]

{ #category : #'t - relayoutable window element - private layout' }
TToRelayoutableWindowElement >> refreshLayout [

	self layoutStep: self newStartLayoutStep
]
