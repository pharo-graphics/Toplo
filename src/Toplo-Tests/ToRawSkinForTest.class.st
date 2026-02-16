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
ToRawSkinForTest >> dragEndedSkinEvent: anEvent [

	super dragEndedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> dragHoveredSkinEvent: anEvent [

	super dragHoveredSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> dragLeftSkinEvent: anEvent [

	super dragLeftSkinEvent: anEvent.
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
ToRawSkinForTest >> leftSkinEvent: anEvent [

	super leftSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> openedSkinEvent: anEvent [

	super openedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
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
ToRawSkinForTest >> releasedSkinEvent: anEvent [

	super releasedSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> selectableSkinEvent: anEvent [

	super selectableSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> selectedSkinEvent: anEvent [

	super selectedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> startStillHoveredSkinEvent: anEvent [

	super startStillHoveredSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> startStillPressedSkinEvent: anEvent [

	super startStillPressedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stillHoveredSkinEvent: anEvent [

	super stillHoveredSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stillPressedSkinEvent: anEvent [

	super stillPressedSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stopStillHoveredSkinEvent: anEvent [

	super stopStillHoveredSkinEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> stopStillPressedSkinEvent: anEvent [

	super stopStillPressedSkinEvent: anEvent.
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

{ #category : #'event handling' }
ToRawSkinForTest >> unselectableSkinEvent: anEvent [

	super unselectableSkinEvent: anEvent.
	self addReceivedEvent: anEvent

]
