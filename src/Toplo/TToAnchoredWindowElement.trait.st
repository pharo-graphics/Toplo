Trait {
	#name : #TToAnchoredWindowElement,
	#instVars : [
		'windowManager',
		'popupTimestamp'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> afterCustomizedToFitAnchorRootDo: aBlock [

	aBlock value
]

{ #category : #'t - inline window element - testing' }
TToAnchoredWindowElement >> allowPickOutsideClosing [

	self manager plugPickOutsideFilter
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> arrangeWindowOnEvent: anEvent [

	self manager arrangeWindowOnEvent: anEvent
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> close [

	self isOpened ifFalse: [ Error signal: 'Closing a closed window' ].
	self manager stopWindow: self.
	self dispatchClosedEvent.

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

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> manager [

	^ windowManager
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> manager: aWindowHandler [

	windowManager := aWindowHandler 
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

	self visibility: BlVisibility hidden.
	self open.
	self whenLayoutedDoOnce: [ " ok, now that sizes are known, 
		position and size of mine or of my children can be adapted "
		self arrangeWindowOnEvent: anEvent.
		" since the position/size could have been changed, 
		one have to wait a second layout"
		self requestLayout.
		self whenLayoutedDoOnce: [
			self afterCustomizedToFitAnchorRootDo: [
				self toFront.
				self visibility: BlVisibility visible ] ] ]
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> preventPickOutsideClosing [

	self manager unplugPickOutsideFilter
]

{ #category : #'t - inline window element - accessing' }
TToAnchoredWindowElement >> root [ 

	^ self
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> toFront [

	self elevation: self defaultElevation
]

{ #category : #'t - inline window element - displaying' }
TToAnchoredWindowElement >> withAllSubwindowsDo: aBlock [

	aBlock value: self
]
