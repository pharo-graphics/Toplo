Class {
	#name : #ToSkinStateGenerator,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target',
		'leaved',
		'dragged',
		'pressed'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'focus events handling' }
ToSkinStateGenerator >> blurEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	self generateBlurStateFromEvent: anEvent
]

{ #category : #'checkable event handling' }
ToSkinStateGenerator >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self generateCheckStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> clickEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	anEvent
		ifPrimary: [ self primaryClickEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged := false.
	leaved ifTrue: [ ^ self ].
	leaved := true.
	
	self generateReleasedStateFromEvent: anEvent.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := false
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged ifFalse: [ ^ self ].
	self generateDraggedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := true
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged := true.
	self generateDragStartedStateFromEvent: anEvent
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dropEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
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
		  ToGeneratorEvent.
		  BlBaseDragEvent.
		  BlBlurEvent.
		  BlFocusEvent.
		  BlClickEvent.
		  BlMouseDownEvent.
		  BlMouseUpEvent.
		  BlMouseEnterEvent.
		  BlMouseLeaveEvent.
		  ToCheckableCheckEvent.
		  ToListNodeSelectedEvent.
		  ToPickOutsideEvent }
]

{ #category : #'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	self generateFocusStateFromEvent: anEvent
]

{ #category : #'state generating' }
ToSkinStateGenerator >> generateBlurStateFromEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
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
					(ToCheckState new checked: anEvent checked; yourself)
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

{ #category : #'list selection' }
ToSkinStateGenerator >> listNodeSelectedEvent: anEvent [

	self generateSelectionStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseDownEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	anEvent
		ifPrimary: [ self primaryMouseDownEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseEnterEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := false.
	dragged ifTrue: [ ^ self ].
	self generateHoveredStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged ifTrue: [ ^ self ].
	leaved ifTrue: [ ^ self ].
	leaved := true.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	anEvent
		ifPrimary: [ self primaryMouseUpEvent: anEvent ]
		secondary: [  ]
		middle: [  ]
		other: [  ]
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

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> pickOutsideEvent: anEvent [
	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	| wasPressed |
	target isEnabled ifFalse: [ ^ self ].
	wasPressed := pressed.
	pressed := false.
	dragged := false.

	wasPressed ifTrue: [ self generateReleasedStateFromEvent: anEvent ].

	leaved ifTrue: [ ^ self ].
	leaved := true.
	target isEnabled ifFalse: [ ^ self ].
	self generateLeavedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryClickEvent: anEvent [

	self generateClickedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseDownEvent: anEvent [

	pressed := true.
	self generatePressedStateFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	dragged := false.
	leaved := false.
	self generateReleasedStateFromEvent: anEvent.
	target isEnabled ifFalse: [ ^ self ].
	self generateHoveredStateFromEvent: anEvent
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillHoveredEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStartStillHoveredSkinEvent sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillPressedEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStartStillPressedSkinEvent sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillHoveredEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillHoveredSkinEvent sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillPressedEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStillPressedSkinEvent sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillHoveredEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStopStillHoveredSkinEvent sourceEvent: anEvent) ]
		for: self target
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillPressedEvent: anEvent [

	self target skinManager
		addSkinStateGeneration: [
			self enqueueTransientStateFromSkinEvent:
				(ToStopStillPressedSkinEvent sourceEvent: anEvent) ]
		for: self target
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
