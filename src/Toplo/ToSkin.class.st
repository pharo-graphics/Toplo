Class {
	#name : 'ToSkin',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'skinStateEngineEpdater'
	],
	#category : 'Toplo-Core-Skin',
	#package : 'Toplo',
	#tag : 'Core-Skin'
}

{ #category : 'event handling' }
ToSkin >> checkedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> clickedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> closedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> deselectedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> disabledLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> dragStartedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> draggedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> droppedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> elementLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> enabledLookEvent: anEvent [


]

{ #category : 'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinChangedEvent.
		  ToElementLookEvent }
]

{ #category : 'event handling' }
ToSkin >> focusedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> hoveredLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> indeterminateLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> initialLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> installLookEvent: anEvent [


]

{ #category : 'testing' }
ToSkin >> isNullSkin [

	^ false
]

{ #category : 'event handling' }
ToSkin >> leavedLookEvent: anEvent [


]

{ #category : 'api - hooks' }
ToSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	" install the event handler that generates state for the state engine"
	anElement skinStateProcessorClass ifNotNil: [ :cls |
		skinStateEngineEpdater := cls new.
		anElement addEventHandler: skinStateEngineEpdater ]
]

{ #category : 'api - hooks' }
ToSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skinStateEngineEpdater ifNotNil: [
		anElement removeEventHandler: skinStateEngineEpdater.
		skinStateEngineEpdater := nil ]
]

{ #category : 'event handling' }
ToSkin >> openedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> pressedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> releasedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> selectedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> skinChangedEvent: anEvent [

	anEvent currentTarget skinStateProcessor refreshStateEvent: anEvent

]

{ #category : 'event handling' }
ToSkin >> stillHoveredLookEvent: anEvent [

]

{ #category : 'event handling' }
ToSkin >> stillPressedLookEvent: anEvent [

]

{ #category : 'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	anEvent currentTarget requestSkin 
]

{ #category : 'event handling' }
ToSkin >> uncheckedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> unfocusedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]
