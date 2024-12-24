Trait {
	#name : #TToWindowElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> afterCustomizedToFitAnchorRootDo: aBlock [

	aBlock value
]

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> arrangeWindowOnEvent: anEvent [
]

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self manager stopWindow: self.
	self dispatchClosedEvent.

]

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : #'t - inline window element - testing' }
TToWindowElement >> hasAssociateElement [

	^ self element notNil
]

{ #category : #'t - inline window element - testing' }
TToWindowElement >> isOpened [

	^ self hasParent
]

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> manager [

	^ windowManager
]

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> open [

	self manager startWindow: self.
	self localTheme ifNil: [ self localTheme: self element lookupTheme ].
	popupTimestamp := self space time now.
	self dispatchOpenedEvent
]

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> popupEvent: anEvent [
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

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> root [ 

	^ self
]

{ #category : #'t - inline window element - displaying' }
TToWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #'t - inline window element - accessing' }
TToWindowElement >> withAllSubwindowsDo: aBlock [

	self items do: [ :i | i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	aBlock value: self

]
