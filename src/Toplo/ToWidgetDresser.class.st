Class {
	#name : #ToWidgetDresser,
	#superclass : #ToDresser,
	#traits : 'TToMouseHandler + TToEnableableHandler',
	#classTraits : 'TToMouseHandler classTrait + TToEnableableHandler classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'deprecated private' }
ToWidgetDresser >> background: aBackground in: anElement [

	self
		deprecated: 'Please send #background: to the element instead.'
		transformWith: '`@receiver background: `@aBackground in: `@anElement'
			-> '`@anElement background: `@aBackground'.
	anElement
		disableEventType: BlElementBackgroundChangedEvent 
		while: [ anElement background: aBackground ]
]

{ #category : #'deprecated private' }
ToWidgetDresser >> border: aBorder in: anElement [

	self
		deprecated: 'Please send #border: to the element instead.'
		transformWith: '`@receiver border: `@aBorder in: `@anElement'
			-> '`@anElement border: `@aBorder'.
	anElement
		disableEventType: BlElementBorderChangedEvent
		while: [ anElement border: aBorder ]
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> clicked: anElement event: anEvent [ 


	self
		deprecated: 'Please use clickEvent:in: instead.'
		transformWith:
			'`@receiver clicked: `@anElement event: `@anEvent'
				-> '`@receiver clickEvent: `@anEvent in: `@anElement'.

	^ self  clickEvent: anEvent in: anElement
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> clickedAvorted: anElement event: anEvent [
 
	" if mouse up is on anElement or on in one of anElement children then it means that a click is done "
	self
		deprecated: 'Please use clickedAvortedEvent:in: instead.'
		transformWith:
			'`@receiver clickedAvorted: `@anElement event: `@anEvent'
				-> '`@receiver clickedAvortedEvent: `@anEvent in: `@anElement'.

	(anEvent upEvent target ~= anElement and: [ (anElement findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> doubleClicked: anElement event: anEvent [

	self
		deprecated: 'Please use clickedAvortedEvent:in: instead.'
		transformWith:
			'`@receiver doubleClicked: `@anElement event: `@anEvent'
				-> '`@receiver doubleClickedEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> hover: anElement event: anEvent [
 
	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> initialState: anElement [
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leftClicked: anElement event: anEvent [

	self
		deprecated: 'Please use leftClickEvent:in: instead.'
		transformWith:
			'`@receiver leftClicked: `@anElement event: `@anEvent'
				-> '`@receiver leftClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leftPressed: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver leftPressed: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseDownEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver leftUp: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.

]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> middleClicked: anElement event: anEvent [

	self
		deprecated: 'Please use middleClickEvent:in: instead.'
		transformWith:
			'`@receiver middleClicked: `@anElement event: `@anEvent'
				-> '`@receiver middleClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> middlePressed: anElement event: anEvent [

	self
		deprecated: 'Please use middleMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver middlePressed: `@anElement event: `@anEvent'
				-> '`@receiver middleMouseDownEvent: `@anEvent in: `@anElement'.

]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> middleUp: anElement event: anEvent [

	self
		deprecated: 'Please use middleMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver middleUp: `@anElement event: `@anEvent'
				-> '`@receiver middleMouseUpEvent: `@anEvent in: `@anElement'.

]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self onInstalledMouseHandlingIn: anElement.
	self onInstalledEnableableHandlingIn: anElement.
	self initialState: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> onUninstalledIn: anElement [

	self onUninstalledMouseHandlingIn: anElement.
	self onUninstalledEnableableHandlingIn: anElement.

	super onUninstalledIn: anElement
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> pressed: anElement event: anEvent [

	self
		deprecated: 'Please use mouseDownEvent:in: instead.'
		transformWith:
			'`@receiver pressed: `@anElement event: `@anEvent'
				-> '`@receiver mouseDownEvent: `@anEvent in: `@anElement'.

	^ self mouseDownEvent: anEvent in: anElement
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> rightClicked: anElement event: anEvent [

	self
		deprecated: 'Please use rightClickEvent:in: instead.'
		transformWith:
			'`@receiver rightClicked: `@anElement event: `@anEvent'
				-> '`@receiver rightClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> rightPressed: anElement event: anEvent [

	self
		deprecated: 'Please use rightMouseDownEvent:in: instead.'
		transformWith:
			'`@receiver rightPressed: `@anElement event: `@anEvent'
				-> '`@receiver rightMouseDownEvent: `@anEvent in: `@anElement'.
]
