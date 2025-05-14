Class {
	#name : #ToBasicSkin,
	#superclass : #ToSkin,
	#category : #'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToBasicSkin >> checkedLookEvent: anEvent [

	self
		deprecated: 'use checkedSkinEvent: instead'
		transformWith:
		'`@rcv  checkedLookEvent: `@arg' -> '`@rcv  checkedSkinEvent: `@arg'.

	self checkedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> checkedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> clickedLookEvent: anEvent [

	self
		deprecated: 'use clickedSkinEvent: instead'
		transformWith:
		'`@rcv clickedLookEvent: `@arg' -> '`@rcv clickedSkinEvent: `@arg'.

	self clickedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> clickedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> closedLookEvent: anEvent [

	self
		deprecated: 'use closedSkinEvent: instead'
		transformWith:
		'`@rcv closedLookEvent: `@arg' -> '`@rcv closedSkinEvent: `@arg'.

	self closedSkinEvent: anEvent

]

{ #category : #'event handling' }
ToBasicSkin >> closedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> deselectedLookEvent: anEvent [

	self
		deprecated: 'use deselectedSkinEvent: instead'
		transformWith:
		'`@rcv  deselectedLookEvent: `@arg' -> '`@rcv  deselectedSkinEvent: `@arg'.

	self deselectedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> deselectedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> disabledLookEvent: anEvent [

	self
		deprecated: 'use disabledSkinEvent: instead'
		transformWith:
		'`@rcv  disabledLookEvent: `@arg' -> '`@rcv  disabledSkinEvent: `@arg'.

	self disabledSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> disabledSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToBasicSkin >> dragStartedLookEvent: anEvent [

	self
		deprecated: 'use dragStartedSkinEvent: instead'
		transformWith:
		'`@rcv  dragStartedLookEvent: `@arg' -> '`@rcv  dragStartedSkinEvent: `@arg'.

	self dragStartedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> dragStartedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> draggedLookEvent: anEvent [

	self
		deprecated: 'use draggedSkinEvent: instead'
		transformWith:
		'`@rcv  draggedLookEvent: `@arg' -> '`@rcv  draggedSkinEvent: `@arg'.

	self draggedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> draggedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> droppedLookEvent: anEvent [

	self
		deprecated: 'use droppedSkinEvent: instead'
		transformWith:
		'`@rcv  droppedLookEvent: `@arg' -> '`@rcv  droppedSkinEvent: `@arg'.

	self droppedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> droppedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> enabledLookEvent: anEvent [

	self
		deprecated: 'use enabledSkinEvent: instead'
		transformWith:
		'`@rcv  enabledLookEvent: `@arg' -> '`@rcv enabledSkinEvent: `@arg'.

	self enabledSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> enabledSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> focusedLookEvent: anEvent [

	self
		deprecated: 'use focusedSkinEvent: instead'
		transformWith:
		'`@rcv  focusedLookEvent: `@arg' -> '`@rcv focusedSkinEvent: `@arg'.

	self focusedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> focusedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> hoveredLookEvent: anEvent [

	self
		deprecated: 'use hoveredSkinEvent: instead'
		transformWith:
		'`@rcv  hoveredLookEvent: `@arg' -> '`@rcv  hoveredSkinEvent: `@arg'.

	self hoveredSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> hoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> indeterminateLookEvent: anEvent [

	self
		deprecated: 'use indeterminateSkinEvent: instead'
		transformWith:
		'`@rcv  indeterminateLookEvent: `@arg' -> '`@rcv  indeterminateSkinEvent: `@arg'.

	self indeterminateSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> indeterminateSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> installLookEvent: anEvent [

	self
		deprecated: 'use installSkinEvent: instead'
		transformWith:
		'`@rcv installLookEvent: `@arg' -> '`@rcv installSkinEvent: `@arg'.

	self installSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> installSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToBasicSkin >> leavedLookEvent: anEvent [

	self
		deprecated: 'use leavedSkinEvent: instead'
		transformWith:
		'`@rcv leavedLookEvent: `@arg' -> '`@rcv leavedSkinEvent: `@arg'.

	self leavedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> leavedSkinEvent: anEvent [

	self
		deprecated: 'Use #leftSkinEvent: instead'
		transformWith:
		'`@rcvr leavedSkinEvent: `@arg' -> '`@rcvr leftSkinEvent: `@arg'.
	self leftSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> leftSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> openedLookEvent: anEvent [

	self
		deprecated: 'use openedSkinEvent: instead'
		transformWith:
		'`@rcv openedLookEvent: `@arg' -> '`@rcv openedSkinEvent: `@arg'.

	self openedSkinEvent: anEvent

]

{ #category : #'event handling' }
ToBasicSkin >> openedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> pressedLookEvent: anEvent [

	self
		deprecated: 'use pressedSkinEvent: instead'
		transformWith:
		'`@rcv pressedLookEvent: `@arg' -> '`@rcv pressedSkinEvent: `@arg'.

	self pressedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> pressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> releasedLookEvent: anEvent [

	self
		deprecated: 'use releasedSkinEvent: instead'
		transformWith:
		'`@rcv releasedLookEvent: `@arg' -> '`@rcv releasedSkinEvent: `@arg'.

	self releasedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> releasedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> selectedLookEvent: anEvent [

	self
		deprecated: 'use selectedSkinEvent: instead'
		transformWith:
		'`@rcv  selectedLookEvent: `@arg' -> '`@rcv  selectedSkinEvent: `@arg'.

	self selectedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> selectedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> startStillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> startStillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> stillHoveredLookEvent: anEvent [

	self
		deprecated: 'use stillHoveredSkinEvent: instead'
		transformWith:
		'`@rcv stillHoveredLookEvent: `@arg' -> '`@rcv stillHoveredSkinEvent: `@arg'.

	self stillHoveredSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> stillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> stillPressedLookEvent: anEvent [

	self
		deprecated: 'use stillPressedSkinEvent: instead'
		transformWith:
		'`@rcv stillPressedLookEvent: `@arg' -> '`@rcv stillPressedSkinEvent: `@arg'.

	self stillPressedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> stillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> stopStillHoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> stopStillPressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToBasicSkin >> uncheckedLookEvent: anEvent [

	self
		deprecated: 'use uncheckedSkinEvent: instead'
		transformWith:
		'`@rcv uncheckedLookEvent: `@arg' -> '`@rcv uncheckedSkinEvent: `@arg'.

	self uncheckedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> uncheckedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToBasicSkin >> unfocusedLookEvent: anEvent [

	self
		deprecated: 'use unfocusedSkinEvent: instead'
		transformWith:
		'`@rcv unfocusedLookEvent: `@arg' -> '`@rcv unfocusedSkinEvent: `@arg'.

	self unfocusedSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> unfocusedSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToBasicSkin >> uninstallLookEvent: anEvent [

	self
		deprecated: 'use uninstallSkinEvent: instead'
		transformWith:
		'`@rcv uninstallLookEvent: `@arg' -> '`@rcv uninstallSkinEvent: `@arg'.

	self uninstallSkinEvent: anEvent
]

{ #category : #'event handling' }
ToBasicSkin >> uninstallSkinEvent: anEvent [
]
