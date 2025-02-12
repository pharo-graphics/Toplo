Trait {
	#name : #TToAnchoredWindowElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - inline window element - testing' }
TToAnchoredWindowElement >> allowPickOutsideClosing [

	self manager plugPickOutsideFilter
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #'t - inline window element - private layout' }
TToAnchoredWindowElement >> checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext [

	self layoutStep ifNotNil: [ :ls |
		self layoutStep: (ls nextStepFor: self onEvent: self lastPopupEvent).
		self layoutStep ifNotNil: [
			self requestLayout ] ]
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self manager stopWindow: self.
	self dispatchClosedEvent.

]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> correctedPositionWithinAnchorRoot [

	^ self measuredPosition
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : #'t - inline window element - testing' }
TToAnchoredWindowElement >> hasAssociateElement [

	^ self element notNil
]

{ #category : #'t - inline window element - testing' }
TToAnchoredWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #'t - inline window element - private layout' }
TToAnchoredWindowElement >> lastPopupEvent [

	^ self userData at: #lastPopupEvent ifAbsent: [  ]
]

{ #category : #'t - inline window element - private layout' }
TToAnchoredWindowElement >> lastPopupEvent: anEvent [

	self userData at: #lastPopupEvent put: anEvent
]

{ #category : #'t - inline window element - private layout' }
TToAnchoredWindowElement >> launchOpening [

	self layoutStep: (ToAnchoredWindowOpeningStartStep new
			 nextStepFor: self
			 onEvent: self lastPopupEvent ).
	self open
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> layoutStep [

	^ self userData at: #layoutStep ifAbsent: [  ]
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> layoutStep: aLayoutStep [

	aLayoutStep ifNil: [
		^ self userData removeKey: #layoutStep ifAbsent: [  ] ].
	self userData at: #layoutStep put: aLayoutStep
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> manager [

	^ windowManager
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> measureWindowOnEvent: anEvent [

	self manager measureWindowOnEvent: anEvent
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> open [

	self manager startWindow: self.
	self localTheme ifNil: [ self localTheme: self element lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> popup [
	
	self popupEvent: nil
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> popupEvent: anEvent [
	" I have to set the position here "

	self manager ifNil: [
		Error signal:
			'Can''t popup an anchored window without window manager' ].
	self hasAssociateElement ifFalse: [
		Error signal:
			'Can''t popup an anchored window without associate element' ].
	self element isAttachedToSceneGraph ifFalse: [
		Error signal:
			'Can''t popup an anchored window if the element is not attached to a space' ].
	self element isDisabled ifTrue: [
		Error signal: 'A window with a disabled element shouldn''t popup' ].

	self isOpened ifTrue: [
		Error signal: 'An opened window shouldn''t be asked to popup' ].

	self lastPopupEvent: anEvent.
	self launchOpening.
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> positionWindowOnEvent: anEvent [

	self manager positionWindowOnEvent: anEvent
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> preventPickOutsideClosing [

	self manager unplugPickOutsideFilter
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
