Class {
	#name : #ToGeneralSkin,
	#superclass : #ToSkin,
	#traits : 'TToSkinEventListenerRegistry + TToStyleSheetSkin',
	#classTraits : 'TToSkinEventListenerRegistry classTrait + TToStyleSheetSkin classTrait',
	#category : #'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToGeneralSkin >> checkedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> clickedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> closedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> deselectedSkinEvent: anEvent [
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
ToGeneralSkin >> dragStartedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> draggedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> droppedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> enabledSkinEvent: anEvent [
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
ToGeneralSkin >> hoveredSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> indeterminateSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> installSkinEvent: anEvent [


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
ToGeneralSkin >> openedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> pressedSkinEvent: anEvent [

]

{ #category : #'event handling' }
ToGeneralSkin >> releasedSkinEvent: anEvent [

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
ToGeneralSkin >> stillHoveredSkinEvent: anEvent [

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
ToGeneralSkin >> uncheckedSkinEvent: anEvent [
]

{ #category : #'event handling' }
ToGeneralSkin >> unfocusedSkinEvent: anEvent [


]

{ #category : #'event handling' }
ToGeneralSkin >> uninstallSkinEvent: anEvent [
]
