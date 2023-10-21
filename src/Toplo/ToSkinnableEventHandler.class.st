Class {
	#name : 'ToSkinnableEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'target',
		'leaved',
		'dragged',
		'stillPressedTask',
		'stillHoveredTask'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'state adding' }
ToSkinnableEventHandler >> addCheckStateEvent: anEvent [

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
ToSkinnableEventHandler >> addClickedStateEvent: anEvent [

	target addNextSkinState: (ToClickedState sourceEvent: anEvent)

]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addDisabledStateEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addDragStartedStateEvent: anEvent [

	target addNextSkinState: (ToDragStartedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addDraggedStateEvent: anEvent [

	target addNextSkinState: (ToDraggedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addDroppedStateEvent: anEvent [

	target addNextSkinState: (ToDroppedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addEnabledStateEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent 
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addHoveredStateEvent: anEvent [

	target addNextSkinState: (ToHoveredState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addLeavedStateEvent: anEvent [

	target addNextSkinState: (ToLeavedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addPressedStateEvent: anEvent [

	target addNextSkinState: (ToPressedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addReleasedStateEvent: anEvent [

	target addNextSkinState: (ToReleasedState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addStillHoveredStateEvent: anEvent [

	target addNextSkinState: (ToStillHoveredState sourceEvent: anEvent)
]

{ #category : 'state adding' }
ToSkinnableEventHandler >> addStillPressedStateEvent: anEvent [

	target addNextSkinState: (ToStillPressedState sourceEvent: anEvent)
]

{ #category : 'focus events handling' }
ToSkinnableEventHandler >> blurEvent: anEvent [
]

{ #category : 'checkable event handling' }
ToSkinnableEventHandler >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self addCheckStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= target and: [ (target findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> doubleClickEvent: anEvent [

]

{ #category : 'dnd handlers' }
ToSkinnableEventHandler >> dragEndEvent: anEvent [

	dragged := false.
	self addReleasedStateEvent: anEvent.
	leaved ifTrue: [ self addLeavedStateEvent: anEvent ]
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> dragEnterEvent: anEvent [

	leaved := false
]

{ #category : 'dnd handlers' }
ToSkinnableEventHandler >> dragEvent: anEvent [

	dragged ifFalse: [ ^ self ].
	self addDraggedStateEvent: anEvent
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> dragLeaveEvent: anEvent [

	leaved := true
]

{ #category : 'dnd handlers' }
ToSkinnableEventHandler >> dragStartEvent: anEvent [

	anEvent isConsumed ifFalse: [ ^ self ].
	dragged := true.
	self addDragStartedStateEvent: anEvent
]

{ #category : 'dnd handlers' }
ToSkinnableEventHandler >> dropEvent: anEvent [

	self addDroppedStateEvent: anEvent
]

{ #category : 'enablement' }
ToSkinnableEventHandler >> enablementChangedEvent: anEvent [

	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self addEnabledStateEvent: anEvent ].
	self addDisabledStateEvent: anEvent
	
]

{ #category : 'api - accessing' }
ToSkinnableEventHandler >> eventsToHandle [

	^ { BlUIEvent. BlMousePickOutsideEvent. ToCheckableCheckedEvent. ToEnablementChangedEvent }
]

{ #category : 'api - accessing' }
ToSkinnableEventHandler >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent. BlMouseEnterEvent. BlMouseLeaveEvent  }
]

{ #category : 'focus events handling' }
ToSkinnableEventHandler >> focusEvent: anEvent [
]

{ #category : 'focus events handling' }
ToSkinnableEventHandler >> focusInEvent: anEvent [
]

{ #category : 'focus events handling' }
ToSkinnableEventHandler >> focusOutEvent: anEvent [
]

{ #category : 'api - event managing' }
ToSkinnableEventHandler >> handleEvent: anEvent [

	self stopTasks: anEvent.
	anEvent sendTo: self
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> isPickOutsideEventRelevantForTarget: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ false ].
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> keyDownEvent: anEvent [
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> keyUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> middleClickEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> middleMouseDownEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> middleMouseUpEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseDownOutsideEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseEnterEvent: anEvent [

	leaved := false.
	self startStillHoveredEvent: anEvent.
	self addHoveredStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseLeaveEvent: anEvent [

	leaved := true.
	self addLeavedStateEvent: anEvent


]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseMoveEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseOutEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseOverEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mousePickOutsideEvent: anEvent [


]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseUpEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		  secondary: [ self secondaryMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseUpOutsideEvent: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasInParentChain: target ]) ifTrue: [
		^ self ].

	"MouseUpOutside for a button is managed if a MouseDown (inside) has occured before (with a consequent pressed state).
	So, do not change the state if the button is not in pressed state"
	"target currentSkinState ifNotNil: [ :s | 
		s isPressedState ifFalse: [ ^ self ] ]."
	self addLeavedStateEvent: anEvent.
	self addReleasedStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> mouseWheelEvent: anEvent [
]

{ #category : 'api - hooks' }
ToSkinnableEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	leaved := false.
	dragged := false.
	" need to store the element for mouse outside event interpreting "
	target := anElement
]

{ #category : 'api - hooks' }
ToSkinnableEventHandler >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> otherClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> otherMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> otherMouseUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> primaryClickEvent: anEvent [

	target switchToNextCheckStateOnClick.
	self addClickedStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> primaryMouseDownEvent: anEvent [

	self addPressedStateEvent: anEvent.
	self startStillPressedEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> primaryMouseUpEvent: anEvent [

	self addReleasedStateEvent: anEvent.
	self addHoveredStateEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> secondaryClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> secondaryMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinnableEventHandler >> secondaryMouseUpEvent: anEvent [
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> shortcutEvent: anEvent [
]

{ #category : 'still pressed - hovered' }
ToSkinnableEventHandler >> startStillHoveredEvent: anEvent [

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
ToSkinnableEventHandler >> startStillPressedEvent: anEvent [

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
ToSkinnableEventHandler >> stillHoveredTask [
	
	^ stillHoveredTask 
]

{ #category : 'still pressed - hovered' }
ToSkinnableEventHandler >> stillPressedTask [
	
	^ stillPressedTask 
]

{ #category : 'still pressed - hovered' }
ToSkinnableEventHandler >> stopStillHoveredTaskEvent: anEvent [

	stillHoveredTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseLeaveEvent)) ifFalse: [ ^ self ].
	stillHoveredTask terminate.
	stillHoveredTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinnableEventHandler >> stopStillPressedTaskEvent: anEvent [

	stillPressedTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseUpEvent) or: [
		 anEvent isKindOf: BlMousePickOutsideEvent ]) ifFalse: [ ^ self ].
	stillPressedTask terminate.
	stillPressedTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinnableEventHandler >> stopTasks: anEvent [

	self stopStillPressedTaskEvent: anEvent.
	self stopStillHoveredTaskEvent: anEvent.

]

{ #category : 'accessing' }
ToSkinnableEventHandler >> target [

	^ target
]

{ #category : 'event handling' }
ToSkinnableEventHandler >> textInputEvent: anEvent [
]

{ #category : 'api - event managing' }
ToSkinnableEventHandler >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandle ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].

	^ eventsToHandle anySatisfy: [ :eachEventClass |
		  anEvent isKindOf: eachEventClass ]
]
