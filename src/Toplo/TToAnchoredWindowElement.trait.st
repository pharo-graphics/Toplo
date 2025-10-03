Trait {
	#name : #TToAnchoredWindowElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> allSubwindowsDo: aBlock [
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> anchorElement [

	^ self manager anchorElement
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self stop.
	self dispatchClosedEvent.

]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> closedEventClass [ 

	^ ToAnchoredElementClosedEvent 
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> dispatchClosedEvent [
	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"

	self anchorElement dispatchEvent: self newClosedEvent.
	super dispatchClosedEvent.

]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> dispatchOpenedEvent [

	super dispatchOpenedEvent.
	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"
	self anchorElement dispatchEvent: self newOpenedEvent
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
TToAnchoredWindowElement >> hasManager [

	^ self manager notNil
]

{ #category : #'t - anchored window element - testing' }
TToAnchoredWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> manager [

	^ windowManager
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> openOnEvent: anEvent [

	self startOnEvent: anEvent.
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> openedEventClass [ 

	^ ToAnchoredElementOpenedEvent 
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> popup [
	
	self popupEvent: nil
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> popupEvent: anEvent [

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

	self openOnEvent: anEvent
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> popupTimestamp: aTimestamp [

	popupTimestamp := aTimestamp
]

{ #category : #'t - anchored window element - accessing' }
TToAnchoredWindowElement >> root [
	"Return my current root element.
	root can not be nil"
	
	^ self
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> startOnEvent: anEvent [

	self manager startWindow: self onEvent: anEvent
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> stop [

	self root removeChildren.
	self manager ifNil: [ ^ self ].
	self manager stopWindow: self.

]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #'t - anchored window element - displaying' }
TToAnchoredWindowElement >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
