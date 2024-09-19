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

	self generateBlurStateFromEvent: anEvent
]

{ #category : #'checkable event handling' }
ToSkinStateGenerator >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self generateCheckStateFromEvent: anEvent
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

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	self dragged: false.
	self leaved ifTrue: [ ^ self ].
	self leaved: true.
	
	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToReleasedSkinEvent sourceEvent: anEvent) ]
		in: target.

	target isEnabled ifFalse: [ ^ self ].

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToLeavedSkinEvent sourceEvent: anEvent) ]
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
ToSkinStateGenerator >> enqueueTransientStateFromSkinEvent: aSkinEvent [

	target skinManagerDo: [ :sm |
		sm
			enqueueSkinState: (ToTransientState new
					 skinEvent: aSkinEvent;
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
		  BlClickEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlMousePickOutsideEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  ToWindowEvent.
		  ToListNodeSelectedEvent }
]

{ #category : #'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [

	self generateFocusStateFromEvent: anEvent
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateBlurStateFromEvent: anEvent [

	target skinManagerDo: [ :sm |
		sm
			addSkinStateGeneration: [
				sm
					enqueueSkinState: (ToFocusState new
							 focused: false;
							 yourself)
					in: target ]
			in: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateCheckStateFromEvent: anEvent [

	target skinManagerDo: [ :sm |
		sm
			addSkinStateGeneration: [
				sm
					enqueueSkinState:
					(ToCheckState new checked: anEvent current yourself)
					in: target ]
			in: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClickedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToClickedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClosedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToClosedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDragStartedStateFromEvent: anEvent [

	self dragged: true.
	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToDragStartedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDraggedStateFromEvent: anEvent [

	self dragged ifFalse: [ ^ self ].
	target skinManager
		addDraggedSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToDraggedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDroppedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToDroppedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateFocusStateFromEvent: anEvent [

	target skinManagerDo: [ :sm |
		sm
			addSkinStateGeneration: [
				sm
					enqueueSkinState: (ToFocusState new
							 focused: true;
							 yourself)
					in: target ]
			in: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateHoveredStateFromEvent: anEvent [

	self leaved: false.
	self dragged ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	self startStillHoveredEvent: anEvent.

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToHoveredSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateLeavedStateFromEvent: anEvent [

	self dragged ifTrue: [ ^ self ].
	self leaved ifTrue: [ ^ self ].
	self leaved: true.
	target isEnabled ifFalse: [ ^ self ].

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToLeavedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateOpenedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToOpenedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generatePressedStateFromEvent: anEvent [

	self pressed: true.
	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToPressedSkinEvent sourceEvent: anEvent).
			self startStillPressedEvent: anEvent ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateReleasedStateFromEvent: anEvent [

	self dragged: false.
	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToReleasedSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateSelectionStateFromEvent: anEvent [
	
	target skinManager
		addSkinStateGeneration: [
			target withAllChildrenBreadthFirstDo: [ :child |
				(child hasStamp: #unselectable) ifFalse: [
					child skinManagerDo: [ :sm |
						sm
							enqueueSkinState: (ToSelectionState new
									 selected: anEvent selected;
									 focused: anEvent listElement isFocused;
									 selectionOption: anEvent selectionOption;
									 yourself)
							in: child ] ] ] ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillHoveredStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillHoveredSkinEvent sourceEvent: anEvent) ]
		in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillPressedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillPressedSkinEvent sourceEvent: anEvent) ]
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

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> labelEditorClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> labelEditorOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
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

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> menuWindowClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> menuWindowOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
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
						self enqueueTransientStateFromSkinEvent:
							(ToReleasedSkinEvent sourceEvent: anEvent) ].

					self leaved ifFalse: [
						self leaved: true.
						target isEnabled ifTrue: [
							self enqueueTransientStateFromSkinEvent:
								(ToLeavedSkinEvent sourceEvent: anEvent) ] ] ] ]
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

	self flag: 'Should take care of addSkinStateGeneration: to remove the generation valuable stored for target before setting it to nil'.
	"target := nil."
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

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> overlayWindowClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> overlayWindowOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> popupWindowClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> popupWindowOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
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
		self enqueueTransientStateFromSkinEvent: (ToReleasedSkinEvent sourceEvent: anEvent).
		target isEnabled ifTrue: [
			self startStillHoveredEvent: anEvent.
			self enqueueTransientStateFromSkinEvent:
				(ToHoveredSkinEvent sourceEvent: anEvent) ] ] in: target
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
	target ifNil: [ ^ self ].
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
			                    (Delay forMilliseconds: 50) wait ] ]
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
		                    (Delay forMilliseconds: 10) wait ] ]
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

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> tooltipWindowClosedEvent: anEvent [

	self generateClosedStateFromEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToSkinStateGenerator >> tooltipWindowOpenedEvent: anEvent [

	self generateOpenedStateFromEvent: anEvent
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> wantsEvent: anEvent [

	target isEnabled ifFalse: [ ^ false ].
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
