Class {
	#name : #ToRawSkinForTest,
	#superclass : #ToRawSkin,
	#instVars : [
		'receivedEvents'
	],
	#category : 'Toplo-Tests-Core-Theme'
}

{ #category : #accessing }
ToRawSkinForTest >> addReceivedEvent: anEvent [

	self receivedEvents at: anEvent class ifAbsentPut: [ OrderedCollection new ].
	(self receivedEvents at: anEvent class) add: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> checkedLookEvent: anEvent [

	super checkedLookEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> clickedLookEvent: anEvent [

	super clickedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> closedLookEvent: anEvent [

	super closedLookEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> deselectedLookEvent: anEvent [

	super deselectedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> disabledLookEvent: anEvent [

	super disabledLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> dragStartedLookEvent: anEvent [

	super dragStartedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> draggedLookEvent: anEvent [

	super draggedLookEvent: anEvent.
	self addReceivedEvent: anEvent
]

{ #category : #'event handling' }
ToRawSkinForTest >> droppedLookEvent: anEvent [

	super droppedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> enabledLookEvent: anEvent [

	super enabledLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> hoveredLookEvent: anEvent [

	super hoveredLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> indeterminateLookEvent: anEvent [

	super indeterminateLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #initialization }
ToRawSkinForTest >> initialize [ 

	super initialize.
	receivedEvents := IdentityDictionary new.
]

{ #category : #'event handling' }
ToRawSkinForTest >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> leavedLookEvent: anEvent [

	super leavedLookEvent: anEvent.
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
ToRawSkinForTest >> selectedLookEvent: anEvent [

	super selectedLookEvent: anEvent.
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
ToRawSkinForTest >> uncheckedLookEvent: anEvent [

	super uncheckedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	self addReceivedEvent: anEvent

]

{ #category : #'event handling' }
ToRawSkinForTest >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	self addReceivedEvent: anEvent
]
