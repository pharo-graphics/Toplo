Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'popupTimestamp',
		'windowManager'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #accessing }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	windowManager applyPositionHookFromEvent: anEvent
]

{ #category : #accessing }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self dispatchClosedEvent.
	super close
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> correctedPositionWithinAnchorRoot [

	^ self position
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
ToAnchoredWindow >> onPositionChangedToFitAnchorRootDo: aBlock [

	| p |
	p := self correctedPositionWithinAnchorRoot.
	p ~= self position ifTrue: [
		self position: p.
		self whenLayoutedDoOnce: aBlock.
		^ self ].
	aBlock value
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> open [

	self show.
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
		Error signal: 'An opened window shouldn''t been asked to popup' ].

	self visibility: BlVisibility hidden.
	self open.
	self whenLayoutedDoOnce: [ " ok, now that my size is known, 
		size and position hooks can be applied "
		self checkBeforePopupEvent: anEvent.
		" since the position/size could have been changed, one have to wait a second layout"
		self requestLayout.
		self whenLayoutedDoOnce: [
			self onPositionChangedToFitAnchorRootDo: [
				self toFront.
				self visibility: BlVisibility visible ] ] ]
]

{ #category : #accessing }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> show [

	self anchorRoot addChild: self
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> toThemeInstalled [

	| lt |
	self element ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

{ #category : #testing }
ToAnchoredWindow >> useMorphicHost [ 

	^ BlHost preferableHostClass = BlMorphicWindowHost
]

{ #category : #accessing }
ToAnchoredWindow >> windowManager [ 

	^ windowManager 
]
