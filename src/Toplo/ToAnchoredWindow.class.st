Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'popupTimestamp',
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToAnchoredWindow >> afterCustomizedToFitAnchorRootDo: aBlock [

	aBlock value
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> allowPickOutsideClosing [

	windowManager plugPickOutsideFilter
]

{ #category : #accessing }
ToAnchoredWindow >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> arrangeWindowOnEvent: anEvent [

	windowManager arrangeWindowOnEvent: anEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self manager stopWindow: self.
	self dispatchClosedEvent.

]

{ #category : #accessing }
ToAnchoredWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchClosedEvent [

	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"
	super dispatchClosedEvent.
	self element  dispatchEvent: self newClosedEvent.

]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEvent [

	super dispatchOpenedEvent.
	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"
	self element dispatchEvent: self newOpenedEvent 
]

{ #category : #accessing }
ToAnchoredWindow >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : #testing }
ToAnchoredWindow >> hasAssociateElement [

	^ self element notNil
]

{ #category : #accessing }
ToAnchoredWindow >> manager [

	^ windowManager 
]

{ #category : #accessing }
ToAnchoredWindow >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> open [

	self manager startWindow: self.
	self localTheme ifNil: [ self localTheme: self element lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> popup [
	
	self popupEvent: nil
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> popupEvent: anEvent [
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

	self visibility: BlVisibility hidden.
	self open.
	self whenLayoutedDoOnce: [ " ok, now that my size is known, 
		size and position hooks can be applied "
		self arrangeWindowOnEvent: anEvent.
		" since the position/size could have been changed, one have to wait a second layout"
		self requestLayout.
		self whenLayoutedDoOnce: [
			self afterCustomizedToFitAnchorRootDo: [
				self toFront.
				self visibility: BlVisibility visible ] ] ]
]

{ #category : #accessing }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> preventPickOutsideClosing [

	windowManager unplugPickOutsideFilter
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> toThemeInstalled [

	| lt |
	self element ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

{ #category : #accessing }
ToAnchoredWindow >> windowManager [

	self
		deprecated: 'Use #manager instead'
		transformWith: '`@rcvr windowManager' -> '`@rcvr manager'.
	^ self manager
]
