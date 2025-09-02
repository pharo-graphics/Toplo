Class {
	#name : #ToGeneralSkin,
	#superclass : #ToSkin,
	#traits : 'TToSkinEventListenerRegistry + TToStyleSheetSkin',
	#classTraits : 'TToSkinEventListenerRegistry classTrait + TToStyleSheetSkin classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToGeneralSkin >> checkedLookEvent: anEvent [

	self
		deprecated: 'use checkedSkinEvent: instead'
		transformWith:
		'`@rcv  checkedLookEvent: `@arg' -> '`@rcv  checkedSkinEvent: `@arg'.

	self checkedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> checkedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> clickedLookEvent: anEvent [

	self
		deprecated: 'use clickedSkinEvent: instead'
		transformWith:
		'`@rcv clickedLookEvent: `@arg' -> '`@rcv clickedSkinEvent: `@arg'.

	self clickedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> clickedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> closedLookEvent: anEvent [

	self
		deprecated: 'use closedSkinEvent: instead'
		transformWith:
		'`@rcv closedLookEvent: `@arg' -> '`@rcv closedSkinEvent: `@arg'.

	self closedSkinEvent: anEvent

]

{ #category : #'event handling' }
ToGeneralSkin >> closedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> deselectedLookEvent: anEvent [

	self
		deprecated: 'use deselectedSkinEvent: instead'
		transformWith:
		'`@rcv  deselectedLookEvent: `@arg' -> '`@rcv  deselectedSkinEvent: `@arg'.

	self deselectedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> deselectedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> disabledLookEvent: anEvent [

	self
		deprecated: 'use disabledSkinEvent: instead'
		transformWith:
		'`@rcv  disabledLookEvent: `@arg' -> '`@rcv  disabledSkinEvent: `@arg'.

	self disabledSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> disabledSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToGeneralSkin >> dragEndedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> dragHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> dragLeftSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> dragStartedLookEvent: anEvent [

	self
		deprecated: 'use dragStartedSkinEvent: instead'
		transformWith:
		'`@rcv  dragStartedLookEvent: `@arg' -> '`@rcv  dragStartedSkinEvent: `@arg'.

	self dragStartedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> dragStartedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> draggedLookEvent: anEvent [

	self
		deprecated: 'use draggedSkinEvent: instead'
		transformWith:
		'`@rcv  draggedLookEvent: `@arg' -> '`@rcv  draggedSkinEvent: `@arg'.

	self draggedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> draggedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> droppedLookEvent: anEvent [

	self
		deprecated: 'use droppedSkinEvent: instead'
		transformWith:
		'`@rcv  droppedLookEvent: `@arg' -> '`@rcv  droppedSkinEvent: `@arg'.

	self droppedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> droppedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> enabledLookEvent: anEvent [

	self
		deprecated: 'use enabledSkinEvent: instead'
		transformWith:
		'`@rcv  enabledLookEvent: `@arg' -> '`@rcv enabledSkinEvent: `@arg'.

	self enabledSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> enabledSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> focusedLookEvent: anEvent [

	self
		deprecated: 'use focusedSkinEvent: instead'
		transformWith:
		'`@rcv  focusedLookEvent: `@arg' -> '`@rcv focusedSkinEvent: `@arg'.

	self focusedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> focusedSkinEvent: anEvent [

]

{ #category : #'api - event managing' }
ToGeneralSkin >> handleEvent: anEvent [

	super handleEvent: anEvent.
	anEvent sendToStyleSheetSkin: self
]

{ #category : #'event handling' }
ToGeneralSkin >> hoveredLookEvent: anEvent [

	self
		deprecated: 'use hoveredSkinEvent: instead'
		transformWith:
		'`@rcv  hoveredLookEvent: `@arg' -> '`@rcv  hoveredSkinEvent: `@arg'.

	self hoveredSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> hoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> indeterminateLookEvent: anEvent [

	self
		deprecated: 'use indeterminateSkinEvent: instead'
		transformWith:
		'`@rcv  indeterminateLookEvent: `@arg' -> '`@rcv  indeterminateSkinEvent: `@arg'.

	self indeterminateSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> indeterminateSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> installLookEvent: anEvent [

	self
		deprecated: 'use installSkinEvent: instead'
		transformWith:
		'`@rcv installLookEvent: `@arg' -> '`@rcv installSkinEvent: `@arg'.

	self installSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> installSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToGeneralSkin >> leavedLookEvent: anEvent [

	self
		deprecated: 'use leavedSkinEvent: instead'
		transformWith:
		'`@rcv leavedLookEvent: `@arg' -> '`@rcv leavedSkinEvent: `@arg'.

	self leavedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> leavedSkinEvent: anEvent [

	self
		deprecated: 'Use #leftSkinEvent: instead'
		transformWith:
		'`@rcvr leavedSkinEvent: `@arg' -> '`@rcvr leftSkinEvent: `@arg'.
	self leftSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> leftSkinEvent: anEvent [
]

{ #category : #'api - hooks' }
ToGeneralSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	(anElement lookupTheme applicableListenersFor: anElement)
		ifNotEmpty: [ :writers | self skinEventListeners: writers ]
]

{ #category : #'event handling' }
ToGeneralSkin >> openedLookEvent: anEvent [

	self
		deprecated: 'use openedSkinEvent: instead'
		transformWith:
		'`@rcv openedLookEvent: `@arg' -> '`@rcv openedSkinEvent: `@arg'.

	self openedSkinEvent: anEvent

]

{ #category : #'event handling' }
ToGeneralSkin >> openedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> pressedLookEvent: anEvent [

	self
		deprecated: 'use pressedSkinEvent: instead'
		transformWith:
		'`@rcv pressedLookEvent: `@arg' -> '`@rcv pressedSkinEvent: `@arg'.

	self pressedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> pressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> releasedLookEvent: anEvent [

	self
		deprecated: 'use releasedSkinEvent: instead'
		transformWith:
		'`@rcv releasedLookEvent: `@arg' -> '`@rcv releasedSkinEvent: `@arg'.

	self releasedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> releasedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> selectedLookEvent: anEvent [

	self
		deprecated: 'use selectedSkinEvent: instead'
		transformWith:
		'`@rcv  selectedLookEvent: `@arg' -> '`@rcv  selectedSkinEvent: `@arg'.

	self selectedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> selectedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> startStillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> startStillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> stillHoveredLookEvent: anEvent [

	self
		deprecated: 'use stillHoveredSkinEvent: instead'
		transformWith:
		'`@rcv stillHoveredLookEvent: `@arg' -> '`@rcv stillHoveredSkinEvent: `@arg'.

	self stillHoveredSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> stillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> stillPressedLookEvent: anEvent [

	self
		deprecated: 'use stillPressedSkinEvent: instead'
		transformWith:
		'`@rcv stillPressedLookEvent: `@arg' -> '`@rcv stillPressedSkinEvent: `@arg'.

	self stillPressedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> stillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> stopStillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> stopStillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> uncheckedLookEvent: anEvent [

	self
		deprecated: 'use uncheckedSkinEvent: instead'
		transformWith:
		'`@rcv uncheckedLookEvent: `@arg' -> '`@rcv uncheckedSkinEvent: `@arg'.

	self uncheckedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> uncheckedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> unfocusedLookEvent: anEvent [

	self
		deprecated: 'use unfocusedSkinEvent: instead'
		transformWith:
		'`@rcv unfocusedLookEvent: `@arg' -> '`@rcv unfocusedSkinEvent: `@arg'.

	self unfocusedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> unfocusedSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToGeneralSkin >> uninstallLookEvent: anEvent [

	self
		deprecated: 'use uninstallSkinEvent: instead'
		transformWith:
		'`@rcv uninstallLookEvent: `@arg' -> '`@rcv uninstallSkinEvent: `@arg'.

	self uninstallSkinEvent: anEvent
]

{ #category : #'event handling' }
ToGeneralSkin >> uninstallSkinEvent: anEvent [
]
