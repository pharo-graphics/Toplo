Class {
	#name : #ToSkinStateGenerator,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target',
		'leaved',
		'dragged',
		'pressed',
		'stillPressedTask',
		'stillHoveredTask'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'focus events handling' }
ToSkinStateGenerator >> blurEvent: anEvent [

	self generateFocusStateFromEvent: anEvent
]

{ #category : #'checkable event handling' }
ToSkinStateGenerator >> checkableCheckedEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self generateCheckStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> clickAbortedEvent: anEvent [

	(anEvent upEvent target hasInParentChain: target) ifFalse: [ ^ self ].
	anEvent target: target.
	anEvent currentTarget: target.
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> clickEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryClickEvent: anEvent ]
		  secondary: [ self secondaryClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self otherClickEvent: anEvent ]
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> contextMenuClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> contextMenuOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> doubleClickEvent: anEvent [

]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self dragged: false.
			self enqueueTransientStateFromLookEvent:
				(ToReleasedLookEvent sourceEvent: anEvent).
			self leaved ifFalse: [
				self leaved: true.
				target isEnabled ifTrue: [
					self enqueueTransientStateFromLookEvent:
						(ToLeavedLookEvent sourceEvent: anEvent) ] ] ]
		in: target
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	self leaved: false
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	self generateDraggedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	self leaved: true
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	self generateDragStartedStateFromEvent: anEvent
]

{ #category : #accessing }
ToSkinStateGenerator >> dragged [

	^ dragged
]

{ #category : #accessing }
ToSkinStateGenerator >> dragged: aBoolean [

	dragged := aBoolean
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dropEvent: anEvent [

	self generateDroppedStateFromEvent: anEvent
]

{ #category : #'state generating' }
ToSkinStateGenerator >> enqueueTransientStateFromLookEvent: aLookEvent [

	target skinManagerDo: [ :sm |
		sm
			enqueueSkinState: (ToTransientState new
					 lookEvent: aLookEvent;
					 yourself)
			in: target ]
]

{ #category : #'api - accessing' }
ToSkinStateGenerator >> eventsToHandle [

	^ {
		  ToCheckableCheckEvent.
		  BlBaseDragEvent.
		  BlKeyboardEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  BlClickAbortedEvent.
		  BlClickEvent.
		  BlDoubleClickEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlMousePickOutsideEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  ToWindowOpenedEvent.
		  ToWindowClosedEvent.
		  ToListNodeSelectedEvent }
]

{ #category : #'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [

	self generateFocusStateFromEvent: anEvent
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateCheckStateFromEvent: anEvent [

	target skinManagerDo: [ :sm |
		sm
			addSkinStateGeneration: [
				target withAllChildrenBreadthFirstDo: [ :child |
					child skinManagerDo: [ :csm |
						csm
							enqueueSkinState:
							(ToCheckState new checked: anEvent current yourself)
							in: child ] ] ]
			in: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClickedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToClickedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClosedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToClosedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDragStartedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self dragged: true.
			self enqueueTransientStateFromLookEvent:
				(ToDragStartedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDraggedStateFromEvent: anEvent [

	target skinManager
		addDraggedSkinStateGeneration: [
			self dragged ifTrue: [
				self enqueueTransientStateFromLookEvent:
					(ToDraggedLookEvent sourceEvent: anEvent) ] ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDroppedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToDroppedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateFocusStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			target withAllChildrenBreadthFirstDo: [ :child |
				child skinManagerDo: [ :sm |
					sm
						enqueueSkinState:
						(ToFocusState new focused: target hasFocus yourself)
						in: target ] ] ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateHoveredStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self leaved: false.
			self dragged ifFalse: [
				self startStillHoveredEvent: anEvent.
				target isEnabled ifTrue: [
					self enqueueTransientStateFromLookEvent:
						(ToHoveredLookEvent sourceEvent: anEvent) ] ] ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateLeavedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self dragged ifFalse: [
				self leaved ifFalse: [
					self leaved: true.
					target isEnabled ifTrue: [
						self enqueueTransientStateFromLookEvent:
							(ToLeavedLookEvent sourceEvent: anEvent) ] ] ] ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateOpenedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToOpenedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generatePressedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self pressed: true.
			self enqueueTransientStateFromLookEvent:
				(ToPressedLookEvent sourceEvent: anEvent).
			self startStillPressedEvent: anEvent ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateReleasedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self dragged: false.
			self enqueueTransientStateFromLookEvent:
				(ToReleasedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateSelectionStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			target withAllChildrenBreadthFirstDo: [ :child |
				child skinManagerDo: [ :sm |
					sm
						enqueueSkinState: (ToSelectionState new
								 selected: anEvent selected;
								 focused: anEvent listElement hasFocus;
								 yourself)
						in: child ] ] ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillHoveredStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToStillHoveredLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillPressedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromLookEvent:
				(ToStillPressedLookEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> handleEvent: anEvent [

	self stopTasks: anEvent.
	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> isPickOutsideEventRelevantForTarget: anEvent [

	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "
	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasParent: target ]) ifTrue: [
		^ false ].
]

{ #category : #'keyboard handlers' }
ToSkinStateGenerator >> keyDownEvent: anEvent [

]

{ #category : #'keyboard handlers' }
ToSkinStateGenerator >> keyUpEvent: anEvent [
]

{ #category : #accessing }
ToSkinStateGenerator >> leaved [

	^ leaved
]

{ #category : #accessing }
ToSkinStateGenerator >> leaved: aBoolean [

	leaved := aBoolean
]

{ #category : #'list selection' }
ToSkinStateGenerator >> listNodeSelectedEvent: anEvent [

	self generateSelectionStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> middleClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> middleMouseDownEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> middleMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseDownEvent: anEvent [

	anEvent
		  ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		  secondary: [ self secondaryMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self otherMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseDownOutsideEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseEnterEvent: anEvent [

	self generateHoveredStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [


	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseMoveEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseOutEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseOverEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mousePickOutsideEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpEvent: anEvent [
	anEvent
		  ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		  secondary: [ self secondaryMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self otherMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpOutsideEvent: anEvent [
	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	target skinManager
		addSkinStateGeneration: [
			| wasPressed |
			wasPressed := self pressed.
			self pressed: false.
			(anEvent originalEvent target notNil and: [
				 anEvent originalEvent target hasInParentChain: target ])
				ifFalse: [
					self dragged: false.
					wasPressed ifTrue: [
						self enqueueTransientStateFromLookEvent:
							(ToReleasedLookEvent sourceEvent: anEvent) ].

					self leaved ifFalse: [
						self leaved: true.
						target isEnabled ifTrue: [
							self enqueueTransientStateFromLookEvent:
								(ToLeavedLookEvent sourceEvent: anEvent) ] ] ] ]
		in: target
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseWheelEvent: anEvent [
]

{ #category : #'api - hooks' }
ToSkinStateGenerator >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	leaved := false.
	dragged := false.
	pressed := false.
	" need to store the element for mouse outside event interpreting "
	target := anElement
]

{ #category : #'api - hooks' }
ToSkinStateGenerator >> onUninstalledIn: anElement [

	target := nil.
	super onUninstalledIn: anElement
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> otherClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> otherMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> otherMouseUpEvent: anEvent [
]

{ #category : #accessing }
ToSkinStateGenerator >> pressed [

	^ pressed
]

{ #category : #accessing }
ToSkinStateGenerator >> pressed: aBoolean [

	pressed := aBoolean
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryClickEvent: anEvent [

	target switchToNextCheckStateOnClick.
	self generateClickedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseDownEvent: anEvent [

	self generatePressedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	target skinManager addSkinStateGeneration: [
		self dragged: false.
		self leaved: false.
		self enqueueTransientStateFromLookEvent: (ToReleasedLookEvent sourceEvent: anEvent).
		target isEnabled ifTrue: [
			self startStillHoveredEvent: anEvent.
			self enqueueTransientStateFromLookEvent:
				(ToHoveredLookEvent sourceEvent: anEvent) ] ] in: target
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> secondaryClickEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> secondaryMouseDownEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> secondaryMouseUpEvent: anEvent [
]

{ #category : #'still pressed - hovered' }
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

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillPressedEvent: anEvent [

	| startDelay space targetPos |
	target space ifNil: [ ^ self ].
	space := target space.
	startDelay := target stillPressedStartDelay.
	startDelay ifNil: [ ^ self ].
	targetPos := target bounds inSpace bounds position.
	stillPressedTask := [
	                    startDelay asDelay wait.
	                    [
	                    space isOpened and: [
		                    target space notNil and: [
			                    anEvent isConsumed not and: [
				                    target bounds inSpace bounds position
				                    = targetPos ] ] ] ] whileTrue: [
		                    self generateStillPressedStateFromEvent: anEvent.
		                    (Delay forMilliseconds: 10) wait.
		                    target spaceDo: [ :sp | sp requestNextPulse ] ] ]
		                    forkAt: Processor userBackgroundPriority
		                    named: self class name , ' stillPressedTask'
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillHoveredTask [
	
	^ stillHoveredTask 
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillPressedTask [
	
	^ stillPressedTask 
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillHoveredTaskEvent: anEvent [

	stillHoveredTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseLeaveEvent)) ifFalse: [ ^ self ].
	stillHoveredTask terminate.
	stillHoveredTask := nil
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillPressedTaskEvent: anEvent [

	stillPressedTask ifNil: [ ^ self ].
	((anEvent isKindOf: BlMouseUpEvent) or: [
		 anEvent isKindOf: BlMousePickOutsideEvent ]) ifFalse: [ ^ self ].
	stillPressedTask terminate.
	stillPressedTask := nil
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopTasks: anEvent [

	self stopStillPressedTaskEvent: anEvent.
	self stopStillHoveredTaskEvent: anEvent.

]

{ #category : #accessing }
ToSkinStateGenerator >> target [

	^ target
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> wantsEvent: anEvent [

	anEvent currentTarget isEnabled ifFalse: [ ^ false ].
	^ super wantsEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> windowClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> windowOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
]
