Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#traits : 'TToAnchoredWindowElement',
	#classTraits : 'TToAnchoredWindowElement classTrait',
	#category : #'Toplo-Core-Window'
}

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
