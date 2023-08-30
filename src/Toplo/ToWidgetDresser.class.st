Class {
	#name : #ToWidgetDresser,
	#superclass : #ToDresser,
	#traits : 'TToMouseHandler + TToEnableableHandler',
	#classTraits : 'TToMouseHandler classTrait + TToEnableableHandler classTrait',
	#instVars : [
		'mouseUpOutsideHandler'
	],
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

{ #category : #'events handling' }
ToWidgetDresser >> clicked: anElement [

	anElement dispatchLookEvent: ToClickLookEvent new.
	self hoveredState: anElement 

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

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> disabledState: anElement [

	mouseEventListener ifNotNil: [ :l | anElement removeEventHandler: l ].
	anElement switchToSkinState: ToDisabledState new
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> doubleClicked: anElement event: anEvent [

	self
		deprecated: 'Please use clickedAvortedEvent:in: instead.'
		transformWith:
			'`@receiver doubleClicked: `@anElement event: `@anEvent'
				-> '`@receiver doubleClickedEvent: `@anEvent in: `@anElement'.
]

{ #category : #'t - enableable handler - events handling' }
ToWidgetDresser >> enablementEvent: anEvent in: anElement [

	anElement isEnabled ifTrue: [ ^ self initialState: anElement ].
	self disabledState: anElement
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> hover: anElement event: anEvent [
 
	self
		deprecated: 'Please use mouseEnterEvent:in: instead.'
		transformWith:
			'`@receiver hover: `@anElement event: `@anEvent'
				-> '`@receiver mouseEnterEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToWidgetDresser >> hoveredState: anElement [

	anElement switchToSkinState: ToHoveredState new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> initialState: anElement [

	" when switch back to enabled state, one have to reinstall mouseListener"
	(anElement eventDispatcher hasHandler: mouseEventListener) ifFalse: [
		anElement addEventHandler: mouseEventListener ].
	anElement switchToSkinState: ToInitialState new
]

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	" since BlMousePickOutsideEvent is not a BlUIEvent, it is not handled by a BlEventListener"
	mouseUpOutsideHandler := BlEventHandler
		                         on: BlMouseUpOutsideEvent
		                         do: [ :event | self mouseUpOutsideEvent: event in: anElement ].
	anElement addEventHandler: mouseUpOutsideHandler
]

{ #category : #'events handling' }
ToWidgetDresser >> leaved: anElement [

	anElement dispatchLookEvent: ToLeavedLookEvent new
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leaved: anElement event: anEvent [

	self
		deprecated: 'Please use mouseLeavedEvent:in: instead.'
		transformWith:
			'`@receiver leaved: `@anElement event: `@anEvent'
				-> '`@receiver mouseLeavedEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToWidgetDresser >> leftClickEvent: anEvent in: anElement [

	self clicked: anElement
]

{ #category : #'deprecated events handling' }
ToWidgetDresser >> leftClicked: anElement event: anEvent [

	self
		deprecated: 'Please use leftClickEvent:in: instead.'
		transformWith:
			'`@receiver leftClicked: `@anElement event: `@anEvent'
				-> '`@receiver leftClickEvent: `@anEvent in: `@anElement'.
]

{ #category : #'events handling' }
ToWidgetDresser >> leftMouseDownEvent: anEvent in: anElement [

	self pressedState: anElement
]

{ #category : #'events handling' }
ToWidgetDresser >> leftMouseUpEvent: anEvent in: anElement [

	self hoveredState: anElement 


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

{ #category : #'events handling' }
ToWidgetDresser >> mouseEnterEvent: anEvent in: anElement [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self hoveredState: anElement
]

{ #category : #'events handling' }
ToWidgetDresser >> mouseLeaveEvent: anEvent in: anElement [

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	self leaved: anElement.
	self initialState: anElement



]

{ #category : #'events handling' }
ToWidgetDresser >> mouseUpOutsideEvent: anEvent in: anElement [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: anElement ]) ifTrue: [
		^ self ].
	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	anElement currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ].
	self initialState: anElement
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

{ #category : #'events handling' }
ToWidgetDresser >> pressedState: anElement [

	anElement switchToSkinState: ToPressedState new
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

{ #category : #'api - install/uninstall  hook' }
ToWidgetDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: mouseUpOutsideHandler.
	mouseUpOutsideHandler := nil.
	super uninstallEventListenersIn: anElement

]
