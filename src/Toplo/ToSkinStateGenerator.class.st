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

	target skinManagerDo: [ :sm | sm focusState: false in: target ]
]

{ #category : #'checkable event handling' }
ToSkinStateGenerator >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	target skinManagerDo: [ :sm | sm checkState: anEvent checked in: target ]
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

{ #category : #'window event handling' }
ToSkinStateGenerator >> closedEvent: anEvent [
	" directly dispatch the skin event to allow the hnadling of the closed window 
	(with a closing animation as an example ) "

	target skinManagerDo: [ :sm |
		target dispatchEvent: (ToClosedSkinEvent sourceEvent: anEvent) ]
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged := false.
	self enqueueTransientState: (ToDragEndedSkinEvent sourceEvent: anEvent)
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := false.
	self enqueueTransientState:
		(ToDragHoveredSkinEvent sourceEvent: anEvent)
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged ifFalse: [ ^ self ].
	self enqueueTransientState: (ToDraggedSkinEvent sourceEvent: anEvent)
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := true.
	self enqueueTransientState:
		(ToDragLeftSkinEvent sourceEvent: anEvent)
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged ifTrue: [ ^ self ].
	dragged := true.
	self enqueueTransientState:
		(ToDragStartedSkinEvent sourceEvent: anEvent)
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dropEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	self enqueueTransientState: (ToDroppedSkinEvent sourceEvent: anEvent)
]

{ #category : #'state generating' }
ToSkinStateGenerator >> enqueueTransientState: aState [

	self enqueueTransientState: aState for: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> enqueueTransientState: aState for: anElement [

	anElement skinManagerDo: [ :sm |
		sm enqueueTransientState: aState for: anElement ]
]

{ #category : #'api - accessing' }
ToSkinStateGenerator >> eventsToHandle [

	^ {
		  ToOpenedClosedEvent.
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
		  ToMouseUpOutsideEvent }
]

{ #category : #'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	target skinManagerDo: [ :sm | sm focusState: true in: target ]
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> handleEvent: anEvent [

	anEvent sendToSkinStateGenerator: self
]

{ #category : #'list selection' }
ToSkinStateGenerator >> listNodeSelectedEvent: anEvent [

	"target isEnabled ifFalse: [ ^ self ]."
	target skinManagerDo: [ :sm |
			sm
				selectionState: anEvent selected
				selectionOption: anEvent selectionOption
				focused: anEvent listElement isFocused
				in: target ]
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

	anEvent primaryButtonPressed ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	leaved := false.
	self enqueueTransientState: (ToHoveredSkinEvent sourceEvent: anEvent)
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [

	anEvent primaryButtonPressed ifTrue: [ ^ self ].
	target isEnabled ifFalse: [ ^ self ].
	leaved ifTrue: [ ^ self ].
	leaved := true.
	self enqueueTransientState: (ToLeftSkinEvent sourceEvent: anEvent)
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

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseUpOutsideEvent: anEvent [
	"Outside event can have a button label or icon as target. 
	In that case, no action is triggered "

	| wasPressed |
	target isEnabled ifFalse: [ ^ self ].
	wasPressed := pressed.
	pressed := false.
	dragged := false.

	wasPressed ifTrue: [
		self enqueueTransientState:
			(ToReleasedSkinEvent sourceEvent: anEvent) ].

	leaved ifTrue: [ ^ self ].
	leaved := true.
	target isEnabled ifFalse: [ ^ self ].
	self enqueueTransientState: (ToLeftSkinEvent sourceEvent: anEvent)
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

{ #category : #'window event handling' }
ToSkinStateGenerator >> openedEvent: anEvent [

	self enqueueTransientState: (ToOpenedSkinEvent sourceEvent: anEvent)
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryClickEvent: anEvent [

	self enqueueTransientState: (ToClickedSkinEvent sourceEvent: anEvent)
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseDownEvent: anEvent [

	pressed := true.

	target isMouseUpOutsideSensible ifTrue: [
			| mouseUpOutsideFilter |
			mouseUpOutsideFilter := ToOutsideEventFilter newOneShotInstance
				                        eventsToHandle: { BlMouseUpEvent };
				                        element: target;
				                        yourself.
			target space root addEventFilter: mouseUpOutsideFilter ].

	self enqueueTransientState: (ToPressedSkinEvent sourceEvent: anEvent)
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	dragged := false.
	leaved := false.
	pressed := false.
	self enqueueTransientState:
		(ToReleasedSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillHoveredEvent: anEvent [

	self enqueueTransientState:
		(ToStartStillHoveredSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillPressedEvent: anEvent [

	self enqueueTransientState:
		(ToStartStillPressedSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillHoveredEvent: anEvent [

	self enqueueTransientState:
		(ToStillHoveredSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillPressedEvent: anEvent [

	self enqueueTransientState:
		(ToStillPressedSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillHoveredEvent: anEvent [

	self enqueueTransientState:
		(ToStopStillHoveredSkinEvent sourceEvent: anEvent)
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillPressedEvent: anEvent [

	self enqueueTransientState:
		(ToStopStillPressedSkinEvent sourceEvent: anEvent)
]

{ #category : #accessing }
ToSkinStateGenerator >> target [

	^ target
]
