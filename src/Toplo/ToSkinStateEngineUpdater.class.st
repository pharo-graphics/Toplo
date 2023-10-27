Class {
	#name : 'ToSkinStateEngineUpdater',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'target',
		'leaved',
		'dragged',
		'stillPressedTask',
		'stillHoveredTask'
	],
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addCheckStateEvent: anEvent [

	| newStateClass |
	newStateClass := anEvent current
		                 ifNil: [ ToIndeterminateState ]
		                 ifNotNil: [ :v |
			                 v
				                 ifTrue: [ ToCheckedState ]
				                 ifFalse: [ ToUncheckedState ] ].

	target addNextSkinState: (newStateClass sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addClickedStateEvent: anEvent [

	target addNextSkinState: (ToClickedState sourceEvent: anEvent)

]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addDisabledStateEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addDragStartedStateEvent: anEvent [

	target addNextSkinState: (ToDragStartedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addDraggedStateEvent: anEvent [

	target addNextSkinState: (ToDraggedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addDroppedStateEvent: anEvent [

	target addNextSkinState: (ToDroppedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addEnabledStateEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent 
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addHoveredStateEvent: anEvent [

	target addNextSkinState: (ToHoveredState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addLeavedStateEvent: anEvent [

	target addNextSkinState: (ToLeavedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addPressedStateEvent: anEvent [

	target addNextSkinState: (ToPressedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addReleasedStateEvent: anEvent [

	target addNextSkinState: (ToReleasedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addStillHoveredStateEvent: anEvent [

	target addNextSkinState: (ToStillHoveredState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinStateEngineUpdater >> addStillPressedStateEvent: anEvent [

	target addNextSkinState: (ToStillPressedState sourceEvent: anEvent)
]

{ #category : 'focus events handling' }
ToSkinStateEngineUpdater >> blurEvent: anEvent [
]

{ #category : 'checkable event handling' }
ToSkinStateEngineUpdater >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self addCheckStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= target and: [ (target findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> doubleClickEvent: anEvent [

]

{ #category : 'dnd handlers' }
ToSkinStateEngineUpdater >> dragEndEvent: anEvent [

	dragged := false.
	self addReleasedStateEvent: anEvent.
	leaved ifTrue: [ self addLeavedStateEvent: anEvent ]
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> dragEnterEvent: anEvent [

	leaved := false
]

{ #category : 'dnd handlers' }
ToSkinStateEngineUpdater >> dragEvent: anEvent [

	dragged ifFalse: [ ^ self ].
	self addDraggedStateEvent: anEvent
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> dragLeaveEvent: anEvent [

	leaved := true
]

{ #category : 'dnd handlers' }
ToSkinStateEngineUpdater >> dragStartEvent: anEvent [

	dragged := true.
	self addDragStartedStateEvent: anEvent
]

{ #category : 'dnd handlers' }
ToSkinStateEngineUpdater >> dropEvent: anEvent [

	self addDroppedStateEvent: anEvent
]

{ #category : 'enablement' }
ToSkinStateEngineUpdater >> enablementChangedEvent: anEvent [

	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self addEnabledStateEvent: anEvent ].
	self addDisabledStateEvent: anEvent
	
]

{ #category : 'api - accessing' }
ToSkinStateEngineUpdater >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToCheckableCheckedEvent. ToEnablementChangedEvent }
]

{ #category : 'api - accessing' }
ToSkinStateEngineUpdater >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent. BlMouseEnterEvent. BlMouseLeaveEvent  }
]

{ #category : 'focus events handling' }
ToSkinStateEngineUpdater >> focusEvent: anEvent [
]

{ #category : 'focus events handling' }
ToSkinStateEngineUpdater >> focusInEvent: anEvent [
]

{ #category : 'focus events handling' }
ToSkinStateEngineUpdater >> focusOutEvent: anEvent [
]

{ #category : 'api - event managing' }
ToSkinStateEngineUpdater >> handleEvent: anEvent [

	self stopTasks: anEvent.
	anEvent sendTo: self
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> isPickOutsideEventRelevantForTarget: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ false ].
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> keyDownEvent: anEvent [
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> keyUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> middleClickEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> middleMouseDownEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> middleMouseUpEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseDownOutsideEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseEnterEvent: anEvent [

	leaved := false.
	dragged ifTrue: [ ^ self ].
	self startStillHoveredEvent: anEvent.
	self addHoveredStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseLeaveEvent: anEvent [

	leaved := true.
	dragged ifTrue: [ ^ self ].
	self addLeavedStateEvent: anEvent


]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseMoveEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseOutEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseOverEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mousePickOutsideEvent: anEvent [


]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseUpEvent: anEvent [
	dragged := false.
	anEvent
		  ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		  secondary: [ self secondaryMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseUpOutsideEvent: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasInParentChain: target ]) ifTrue: [
		^ self ].
	dragged := false.
	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	"target currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ]."
	self addLeavedStateEvent: anEvent.
	self addReleasedStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> mouseWheelEvent: anEvent [
]

{ #category : 'api - hooks' }
ToSkinStateEngineUpdater >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	leaved := false.
	dragged := false.
	" need to store the element for mouse outside event interpreting "
	target := anElement
]

{ #category : 'api - hooks' }
ToSkinStateEngineUpdater >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> otherClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> otherMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> otherMouseUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> primaryClickEvent: anEvent [

	target switchToNextCheckStateOnClick.
	self addClickedStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> primaryMouseDownEvent: anEvent [

	self addPressedStateEvent: anEvent.
	self startStillPressedEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> primaryMouseUpEvent: anEvent [

	self addReleasedStateEvent: anEvent.
	self addHoveredStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> secondaryClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> secondaryMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateEngineUpdater >> secondaryMouseUpEvent: anEvent [
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> shortcutEvent: anEvent [
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> startStillHoveredEvent: anEvent [

	| startDelay space |
	target space ifNil: [ ^ self ].
	space := target space.
	startDelay := target stillHoveredStartDelay.
	startDelay ifNil: [ ^ self ].
	stillHoveredTask := [
	                    | event |
	                    event := anEvent copy.
	                    startDelay asDelay wait.
	                    [ space isOpened  and: [ target space notNil and: [event isConsumed not ] ] ]
		                    whileTrue: [
			                    self addStillHoveredStateEvent: event.
			                    (Delay forMilliseconds: 50) wait.
			                    target spaceDo: [ :sp | sp requestNextPulse ] ] ]
		                    forkAt: Processor userBackgroundPriority
		                    named: self class name , ' stillHoveredTask'
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> startStillPressedEvent: anEvent [

	| startDelay space |
	target space ifNil: [ ^ self ].
	space := target space.
	startDelay := target stillPressedStartDelay.
	startDelay ifNil: [ ^ self ].
	stillPressedTask := [
	                    | event |
	                    event := anEvent copy.
	                    startDelay asDelay wait.
	                    [ space isOpened  and: [ target space notNil and: [event isConsumed not ] ] ]
		                    whileTrue: [
			                    self addStillPressedStateEvent: event.
			                    (Delay forMilliseconds: 10) wait.
			                    target spaceDo: [ :sp | sp requestNextPulse ] ] ]
		                    forkAt: Processor userBackgroundPriority
		                    named: self class name , ' stillPressedTask'
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> stillHoveredTask [
	
	^ stillHoveredTask 
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> stillPressedTask [
	
	^ stillPressedTask 
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> stopStillHoveredTaskEvent: anEvent [

	stillHoveredTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseLeaveEvent)) ifFalse: [ ^ self ].
	stillHoveredTask terminate.
	stillHoveredTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> stopStillPressedTaskEvent: anEvent [

	stillPressedTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseUpEvent) or: [
		 anEvent isKindOf: BlMousePickOutsideEvent ]) ifFalse: [ ^ self ].
	stillPressedTask terminate.
	stillPressedTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinStateEngineUpdater >> stopTasks: anEvent [

	self stopStillPressedTaskEvent: anEvent.
	self stopStillHoveredTaskEvent: anEvent.

]

{ #category : 'accessing' }
ToSkinStateEngineUpdater >> target [

	^ target
]

{ #category : 'event handling' }
ToSkinStateEngineUpdater >> textInputEvent: anEvent [
]

{ #category : 'api - event managing' }
ToSkinStateEngineUpdater >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandle ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].

	^ eventsToHandle anySatisfy: [ :eachEventClass |
		  anEvent isKindOf: eachEventClass ]
]
