Class {
	#name : #ToSkinStateGenerator,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'target',
		'leaved',
		'dragged',
		'pressed',
		'selectionIndex'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'focus events handling' }
ToSkinStateGenerator >> blurEvent: anEvent [

	self enqueueSkinState: (ToFocusState new
			 focused: false;
			 yourself)
]

{ #category : #'checkable event handling' }
ToSkinStateGenerator >> checkableCheckEvent: anEvent [
	"ToCheclableCheckEvent can be send either because of a click or because the checkable as been checked programmatically"

	self enqueueSkinState: (ToCheckState new
			 checked: anEvent checked;
			 yourself)
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

	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToClosedSkinEvent sourceEvent: anEvent))
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEndEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged := false.
	leaved ifTrue: [ ^ self ].
	leaved := true.
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToReleasedSkinEvent sourceEvent: anEvent)).
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToLeavedSkinEvent sourceEvent: anEvent))
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEnterEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := false.
	dragged := true
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToDraggedSkinEvent sourceEvent: anEvent))
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragLeaveEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	leaved := true.
	dragged := false
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dragStartEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	dragged := true.
	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToDragStartedSkinEvent sourceEvent: anEvent))
]

{ #category : #'dnd handlers' }
ToSkinStateGenerator >> dropEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToDroppedSkinEvent sourceEvent: anEvent))
]

{ #category : #'state generating' }
ToSkinStateGenerator >> enqueueSkinState: aState [

	self enqueueSkinState: aState in: target
]

{ #category : #'state generating' }
ToSkinStateGenerator >> enqueueSkinState: aState in: anElement [

	anElement skinManagerDo: [ :sm |
		sm
			addSkinStateGeneration: [
			sm enqueueSkinState: aState in: anElement ]
			for: anElement ]
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
		  ToPickOutsideEvent }
]

{ #category : #'focus events handling' }
ToSkinStateGenerator >> focusEvent: anEvent [

	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState: (ToFocusState new
			 focused: true;
			 yourself)
]

{ #category : #'api - event managing' }
ToSkinStateGenerator >> handleEvent: anEvent [

	anEvent sendToSkinStateGenerator: self
]

{ #category : #initialization }
ToSkinStateGenerator >> initialize [ 

	super initialize.
	selectionIndex := IdentityDictionary new
]

{ #category : #'list selection' }
ToSkinStateGenerator >> listNodeSelectedEvent: anEvent [

	| record |
	target isEnabled ifFalse: [ ^ self ].
	" first check if I need the skin event.
	I don't need it if I'm already selected for the same focus state "
	record := selectionIndex at: anEvent selectionOption ifAbsent: [  ].
	record
		ifNil: [
			" not present, just record the selection state "
			selectionIndex at: anEvent selectionOption put: (ToSelectionRecord
					 selected: anEvent selected
					 focused: anEvent listElement isFocused) ]
		ifNotNil: [
			" check if it is for the same selection state "
			(record
				 isSelected: anEvent selected
				 focused: anEvent listElement isFocused) ifTrue: [ ^ self ].
			record selected: anEvent selected.
			record focused: anEvent listElement isFocused ].

	target withAllChildrenBreadthFirstDo: [ :child |
		child areSelectionSkinEventsPrevented ifTrue: [ ^ self ].
		self
			enqueueSkinState: (ToSelectionState new
					 selected: anEvent selected;
					 focused: anEvent listElement isFocused;
					 selectionOption: anEvent selectionOption;
					 yourself)
			in: child ]
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

	leaved := false.
	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToHoveredSkinEvent sourceEvent: anEvent))
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> mouseLeaveEvent: anEvent [

	leaved ifTrue: [ ^ self ].
	leaved := true.
	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToLeavedSkinEvent sourceEvent: anEvent))
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

{ #category : #'window event handling' }
ToSkinStateGenerator >> openedEvent: anEvent [

	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToOpenedSkinEvent sourceEvent: anEvent))
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

	wasPressed ifTrue: [
		self enqueueSkinState: (ToTransientState skinEvent:
				 (ToReleasedSkinEvent sourceEvent: anEvent)) ].

	leaved ifTrue: [ ^ self ].
	leaved := true.
	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToLeavedSkinEvent sourceEvent: anEvent))
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryClickEvent: anEvent [

	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToClickedSkinEvent sourceEvent: anEvent))
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseDownEvent: anEvent [

	pressed := true.
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToPressedSkinEvent sourceEvent: anEvent))
]

{ #category : #'mouse handlers' }
ToSkinStateGenerator >> primaryMouseUpEvent: anEvent [

	dragged := false.
	leaved := false.
	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToReleasedSkinEvent sourceEvent: anEvent)).
	target isEnabled ifFalse: [ ^ self ].
	self enqueueSkinState:
		(ToTransientState skinEvent:
			 (ToHoveredSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillHoveredEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStartStillHoveredSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> startStillPressedEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStartStillPressedSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillHoveredEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStillHoveredSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stillPressedEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStillPressedSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillHoveredEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStopStillHoveredSkinEvent sourceEvent: anEvent))
]

{ #category : #'still pressed - hovered' }
ToSkinStateGenerator >> stopStillPressedEvent: anEvent [

	self enqueueSkinState: (ToTransientState skinEvent:
			 (ToStopStillPressedSkinEvent sourceEvent: anEvent))
]

{ #category : #accessing }
ToSkinStateGenerator >> target [

	^ target
]
