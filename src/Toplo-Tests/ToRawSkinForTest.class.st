Class {
	#name : #ToRawSkinForTest,
	#superclass : #ToRawSkin,
	#instVars : [
		'receivedEvents'
	],
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #accessing }
ToRawSkinForTest >> addReceivedEvent: anEvent [

	self receivedEvents at: anEvent class ifAbsentPut: [ OrderedCollection new ].
	(self receivedEvents at: anEvent class) add: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> checkedSkinEvent: anEvent [

	super checkedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> clickedSkinEvent: anEvent [

	super clickedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> closedSkinEvent: anEvent [

	super closedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> deselectedSkinEvent: anEvent [

	super deselectedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> disabledSkinEvent: anEvent [

	super disabledSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> dragStartedSkinEvent: anEvent [

	super dragStartedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> draggedSkinEvent: anEvent [

	super draggedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> droppedSkinEvent: anEvent [

	super droppedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> enabledSkinEvent: anEvent [

	super enabledSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> focusedSkinEvent: anEvent [

	super focusedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> hoveredSkinEvent: anEvent [

	super hoveredSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> indeterminateSkinEvent: anEvent [

	super indeterminateSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #initialization }
ToRawSkinForTest >> initialize [ 

	super initialize.
	receivedEvents := IdentityDictionary new.
]

{ #category : #'event handling' }
ToRawSkinForTest >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> leavedSkinEvent: anEvent [

	super leavedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> openedLookEvent: anEvent [

	super openedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> pressedLookEvent: anEvent [

	super pressedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #accessing }
ToRawSkinForTest >> receivedCountForClass: anEventClass [

	^ self receivedEvents
		  at: anEventClass
		  ifPresent: [ :found | found size ]
		  ifAbsent: [ 0 ]
]

{ #category : #accessing }
ToRawSkinForTest >> receivedEvents [

	^ receivedEvents ifNil: [ receivedEvents := OrderedCollection new ]
]

{ #category : #'event handling' }
ToRawSkinForTest >> releasedLookEvent: anEvent [

	super releasedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stillHoveredLookEvent: anEvent [

	super stillHoveredLookEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stillPressedLookEvent: anEvent [

	super stillPressedLookEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> uncheckedSkinEvent: anEvent [

	super uncheckedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> unfocusedSkinEvent: anEvent [

	super unfocusedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]
