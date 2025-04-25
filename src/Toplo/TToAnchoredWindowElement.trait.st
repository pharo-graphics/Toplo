Trait {
	#name : #TToAnchoredWindowElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - anchored window element - testing' }
TToAnchoredWindowElement >> allowPickOutsideClosing [

	self manager plugPickOutsideFilter
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> anchorElement [

	^ self manager ifNotNil: [ :h | h anchorElement ]
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext [

	self layoutStep ifNotNil: [ :ls |
		self layoutStep: (ls
				 nextStepFor: self
				 onEvent: self lastPopupEvent
				 onLayout: aBounds
				 context: aBlElementBoundsUpdateContext).
		self layoutStep ifNotNil: [ self requestLayout ] ]
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self stop.
	self dispatchClosedEvent.

]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> correctedPositionWithinAnchorRoot [

	^ self measuredPosition
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> element [

	self deprecated: 'Use #anchorElement instead' transformWith: '`@rcvr element'->'`@rcvr anchorElement'.
	^ self anchorElement
]

{ #category : #'t - anchored window element - testing' }
TToAnchoredWindowElement >> hasAnchorElement [

	^ self anchorElement notNil
]

{ #category : #'t - anchored window element - testing' }
TToAnchoredWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> lastPopupEvent [

	^ self userData at: #lastPopupEvent ifAbsent: [  ]
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> lastPopupEvent: anEvent [

	self userData at: #lastPopupEvent put: anEvent
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> launchOpening [

	self layoutStep: self newStartLayoutStep.
	self open
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> layoutStep [

	^ self userData at: #layoutStep ifAbsent: [  ]
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> layoutStep: aLayoutStep [

	aLayoutStep ifNil: [
		^ self userData removeKey: #layoutStep ifAbsent: [  ] ].
	self userData at: #layoutStep put: aLayoutStep
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> manager [

	^ windowManager
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> newStartLayoutStep [ 

	^ ToAnchoredWindowOpeningStartStep new
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> onMeasure: anExtentMeasurementSpec onEvent: anEvent [

	self manager ifNil: [ ^ self ].
	self manager onMeasure: anExtentMeasurementSpec onEvent: anEvent
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> open [

	self start.
	self localTheme ifNil: [
		self localTheme: self anchorElement lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> popup [
	
	self popupEvent: nil
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> popupEvent: anEvent [
	" I have to set the position here "

	self manager ifNil: [
		Error signal:
			'Can''t popup an anchored window without window manager' ].
	self hasAnchorElement ifFalse: [
		Error signal:
			'Can''t popup an anchored window without associate element' ].
	self anchorElement isAttachedToSceneGraph ifFalse: [
		Error signal:
			'Can''t popup an anchored window if the element is not attached to a space' ].
	self anchorElement isDisabled ifTrue: [
		Error signal: 'A window with a disabled element shouldn''t popup' ].

	self isOpened ifTrue: [
		Error signal: 'An opened window shouldn''t be asked to popup' ].

	self lastPopupEvent: anEvent.
	self launchOpening
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> positionOnEvent: anEvent context: aBlElementBoundsUpdateContext [

	self manager ifNil: [ ^ self ].
	self manager positionWindowOnEvent: anEvent context: aBlElementBoundsUpdateContext
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> preventPickOutsideClosing [

	self manager unplugPickOutsideFilter
]

{ #category : #'t - anchored window element - private layout' }
TToAnchoredWindowElement >> refreshLayout [

	self layoutStep: self newStartLayoutStep.
	self requestLayout
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> start [

	self manager startWindow: self
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> stop [

	self manager stopWindow: self
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
