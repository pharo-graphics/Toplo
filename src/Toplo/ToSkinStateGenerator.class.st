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
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	self dragged: false.
	self leaved ifTrue: [ ^ self ].
	self leaved: true.
	
	self generateReleasedStateFromEvent: anEvent.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	self leaved: false
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	self dragged ifFalse: [ ^ self ].
	self generateDraggedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	self leaved: true
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	self dragged: true.
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
		  BlBlurEvent.
		  BlFocusEvent.
		  BlClickEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlMouseUpOutsideEvent.
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
			for: target ]
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
			for: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClickedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToClickedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateClosedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToClosedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDragStartedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToDragStartedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateDraggedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
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
		for: target
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
			for: target ]
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateHoveredStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToHoveredSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateLeavedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToLeavedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateOpenedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToOpenedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generatePressedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToPressedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateReleasedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToReleasedSkinEvent sourceEvent: anEvent) ]
		for: target
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
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillHoveredStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillHoveredSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateStillPressedStateFromEvent: anEvent [

	target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillPressedSkinEvent sourceEvent: anEvent) ]
		for: target
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> handleEvent: anEvent [

	self stopTasks: anEvent.
	(anEvent isKindOf: ToWindowClosedEvent) ifTrue: [
		^ self windowClosedEvent: anEvent ].
	(anEvent isKindOf: ToWindowOpenedEvent) ifTrue: [
		^ self windowOpenedEvent: anEvent ].
	anEvent sendTo: self
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
ToSkinStateGenerator >> mouseDownEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseEnterEvent: anEvent [

	self leaved: false.
	self dragged ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	self startStillHoveredEvent: anEvent.
	self generateHoveredStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [

	self dragged ifTrue: [ ^ self ].
	self leaved ifTrue: [ ^ self ].
	self leaved: true.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpEvent: anEvent [

	anEvent
		ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpOutsideEvent: anEvent [
	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	| wasPressed |
	wasPressed := self pressed.
	self pressed: false.
	self dragged: false.

	(anEvent originalEvent target notNil and: [
		 anEvent originalEvent target hasInParentChain: target ]) ifTrue: [
		^ self ].

	wasPressed ifTrue: [ self generateReleasedStateFromEvent: anEvent ].

	self leaved ifTrue: [ ^ self ].
	self leaved: true.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'api - hooks' }
ToSkinStateGenerator >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	leaved := true.
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

	self pressed: true.
	self startStillPressedEvent: anEvent.
	self generatePressedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	self dragged: false.
	self leaved: false.
	self generateReleasedStateFromEvent: anEvent.
	target isEnabled ifFalse: [ ^ self ].
	self startStillHoveredEvent: anEvent.
	self generateHoveredStateFromEvent: anEvent
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
