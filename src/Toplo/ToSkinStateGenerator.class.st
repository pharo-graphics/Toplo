Class {
	#name : 'ToSkinStateGenerator',
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

{ #category : 'focus events handling' }
ToSkinStateGenerator >> blurEvent: anEvent [
]

{ #category : 'checkable event handling' }
ToSkinStateGenerator >> checkableCheckedEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self generateCheckStateFromEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> clickAvortedEvent: anEvent [

	(anEvent upEvent target ~= target and: [ (target findMouseEventTargetAt: anEvent upEvent position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> doubleClickEvent: anEvent [

]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	dragged := false.
	self generateReleasedStateFromEvent: anEvent.
	leaved ifTrue: [ self generateLeavedStateFromEvent: anEvent ]
]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	leaved := false
]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	dragged ifFalse: [ ^ self ].
	self generateDraggedStateFromEvent: anEvent
]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	leaved := true
]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	dragged := true.
	self generateDragStartedStateFromEvent: anEvent
]

{ #category : 'dnd handlers' }
ToSkinStateGenerator >> dropEvent: anEvent [

	self generateDroppedStateFromEvent: anEvent
]

{ #category : 'enablement' }
ToSkinStateGenerator >> enablementChangedEvent: anEvent [

	target := anEvent currentTarget.
	target isEnabled ifTrue: [ ^ self generateEnabledStateFromEvent: anEvent ].
	self generateDisabledStateFromEvent: anEvent
	
]

{ #category : 'api - accessing' }
ToSkinStateGenerator >> eventsToHandle [

	^ {
		  ToCheckableCheckedEvent.
		  BlBaseDragEvent.
		  ToEnablementChangedEvent.
		  BlKeyboardEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  BlClickAvortedEvent.
		  BlClickEvent.
		  BlDoubleClickEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlMousePickOutsideEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent }
]

{ #category : 'api - accessing' }
ToSkinStateGenerator >> eventsToHandleWhenDisabled [

	^ { ToEnablementChangedEvent. BlMouseEnterEvent. BlMouseLeaveEvent  }
]

{ #category : 'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateCheckStateFromEvent: anEvent [

	| newStateClass |
	newStateClass := anEvent current
		                 ifNil: [ ToIndeterminateState ]
		                 ifNotNil: [ :v |
			                 v
				                 ifTrue: [ ToCheckedState ]
				                 ifFalse: [ ToUncheckedState ] ].

	target addNextSkinState: (newStateClass sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateClickedStateFromEvent: anEvent [

	target addNextSkinState: (ToClickedState sourceEvent: anEvent)

]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateDisabledStateFromEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateDragStartedStateFromEvent: anEvent [

	target addNextSkinState: (ToDragStartedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateDraggedStateFromEvent: anEvent [

	target addNextSkinState: (ToDraggedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateDroppedStateFromEvent: anEvent [

	target addNextSkinState: (ToDroppedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateEnabledStateFromEvent: anEvent [

	target skinStateEngine refreshStateEvent: anEvent 
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateHoveredStateFromEvent: anEvent [

	target addNextSkinState: (ToHoveredState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateLeavedStateFromEvent: anEvent [

	target addNextSkinState: (ToLeavedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generatePressedStateFromEvent: anEvent [

	target addNextSkinState: (ToPressedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateReleasedStateFromEvent: anEvent [

	target addNextSkinState: (ToReleasedState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateStillHoveredStateFromEvent: anEvent [

	target addNextSkinState: (ToStillHoveredState sourceEvent: anEvent)
]

{ #category : 'state generating' }
ToSkinStateGenerator >> generateStillPressedStateFromEvent: anEvent [

	target addNextSkinState: (ToStillPressedState sourceEvent: anEvent)
]

{ #category : 'api - event managing' }
ToSkinStateGenerator >> handleEvent: anEvent [

	self stopTasks: anEvent.
	anEvent sendTo: self
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> isPickOutsideEventRelevantForTarget: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ false ].
]

{ #category : 'keyboard handlers' }
ToSkinStateGenerator >> keyDownEvent: anEvent [

]

{ #category : 'keyboard handlers' }
ToSkinStateGenerator >> keyUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> middleClickEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> middleMouseDownEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> middleMouseUpEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseDownOutsideEvent: anEvent [

]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseEnterEvent: anEvent [

	leaved := false.
	dragged ifTrue: [ ^ self ].
	self startStillHoveredEvent: anEvent.
	self generateHoveredStateFromEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [

	leaved := true.
	dragged ifTrue: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent


]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseMoveEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseOutEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseOverEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mousePickOutsideEvent: anEvent [


]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseUpEvent: anEvent [
	dragged := false.
	anEvent
		  ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		  secondary: [ self secondaryMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseUpOutsideEvent: anEvent [

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
	self generateLeavedStateFromEvent: anEvent.
	self generateReleasedStateFromEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> mouseWheelEvent: anEvent [
]

{ #category : 'api - hooks' }
ToSkinStateGenerator >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	leaved := false.
	dragged := false.
	" need to store the element for mouse outside event interpreting "
	target := anElement
]

{ #category : 'api - hooks' }
ToSkinStateGenerator >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> otherClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> otherMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> otherMouseUpEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> primaryClickEvent: anEvent [

	target switchToNextCheckStateOnClick.
	self generateClickedStateFromEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> primaryMouseDownEvent: anEvent [

	self generatePressedStateFromEvent: anEvent.
	self startStillPressedEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	self generateReleasedStateFromEvent: anEvent.
	self generateHoveredStateFromEvent: anEvent
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> secondaryClickEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> secondaryMouseDownEvent: anEvent [
]

{ #category : 'mouse handlers' }
ToSkinStateGenerator >> secondaryMouseUpEvent: anEvent [
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> startStillHoveredEvent: anEvent [

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
			                    self generateStillHoveredStateFromEvent: event.
			                    (Delay forMilliseconds: 50) wait.
			                    target spaceDo: [ :sp | sp requestNextPulse ] ] ]
		                    forkAt: Processor userBackgroundPriority
		                    named: self class name , ' stillHoveredTask'
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> startStillPressedEvent: anEvent [

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
			                    self generateStillPressedStateFromEvent: event.
			                    (Delay forMilliseconds: 10) wait.
			                    target spaceDo: [ :sp | sp requestNextPulse ] ] ]
		                    forkAt: Processor userBackgroundPriority
		                    named: self class name , ' stillPressedTask'
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> stillHoveredTask [
	
	^ stillHoveredTask 
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> stillPressedTask [
	
	^ stillPressedTask 
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> stopStillHoveredTaskEvent: anEvent [

	stillHoveredTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseLeaveEvent)) ifFalse: [ ^ self ].
	stillHoveredTask terminate.
	stillHoveredTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> stopStillPressedTaskEvent: anEvent [

	stillPressedTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseUpEvent) or: [
		 anEvent isKindOf: BlMousePickOutsideEvent ]) ifFalse: [ ^ self ].
	stillPressedTask terminate.
	stillPressedTask := nil
]

{ #category : 'still pressed - hovered' }
ToSkinStateGenerator >> stopTasks: anEvent [

	self stopStillPressedTaskEvent: anEvent.
	self stopStillHoveredTaskEvent: anEvent.

]

{ #category : 'accessing' }
ToSkinStateGenerator >> target [

	^ target
]

{ #category : 'api - event managing' }
ToSkinStateGenerator >> wantsEvent: anEvent [

	| eventsToHandle |
	eventsToHandle := anEvent currentTarget isEnabled
		                  ifTrue: [ self eventsToHandle ]
		                  ifFalse: [ self eventsToHandleWhenDisabled ].

	^ eventsToHandle anySatisfy: [ :eachEventClass |
		  anEvent isKindOf: eachEventClass ]
]
