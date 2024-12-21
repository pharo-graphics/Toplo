Class {
	#name : #ToInlineWindowElement,
	#superclass : #ToElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #enumerating }
ToInlineWindowElement >> afterCustomizedToFitAnchorRootDo: aBlock [

	aBlock value
]

{ #category : #'api - displaying' }
ToInlineWindowElement >> arrangeWindowOnEvent: anEvent [
]

{ #category : #'initialize-release' }
ToInlineWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self dispatchClosedEvent.
	self removeFromParent
]

{ #category : #'api - displaying' }
ToInlineWindowElement >> dispatchClosedEvent [

	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"
	super dispatchClosedEvent.
	self element  dispatchEvent: self newClosedEvent.

]

{ #category : #testing }
ToInlineWindowElement >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : #testing }
ToInlineWindowElement >> hasAssociateElement [

	^ self element notNil
]

{ #category : #initialization }
ToInlineWindowElement >> initialize [

	super initialize.
	self fitContent
]

{ #category : #testing }
ToInlineWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #accessing }
ToInlineWindowElement >> manager [

	^ windowManager 
]

{ #category : #accessing }
ToInlineWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'instance creation' }
ToInlineWindowElement >> open [

	self show.
	self localTheme ifNil: [ self localTheme: self element lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'t - menu window model' }
ToInlineWindowElement >> popupEvent: anEvent [
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
ToInlineWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #accessing }
ToInlineWindowElement >> root [ 

	^ self
]

{ #category : #'host space - displaying' }
ToInlineWindowElement >> show [

	self manager showWindow: self 
]

{ #category : #'host space - displaying' }
ToInlineWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #enumerating }
ToInlineWindowElement >> withAllSubwindowsDo: aBlock [

	self childrenDo: [ :i |
		(i isKindOf: self class) ifTrue: [
			i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ] ]
]
