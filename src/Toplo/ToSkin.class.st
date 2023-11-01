Class {
	#name : #ToSkin,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'skinStateEngineEpdater'
	],
	#category : 'Toplo-Core-Skin'
}

{ #category : #'event handling' }
ToSkin >> checkedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> clickedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> closedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> deselectedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> disabledLookEvent: anEvent [


]

{ #category : #'event dispatch' }
ToSkin >> dispatchSkinChangedEventTo: anObject [

	anObject dispatchSkinChangedEvent
]

{ #category : #'event dispatch' }
ToSkin >> dispatchSkinRequestedEventTo: anObject [

	anObject dispatchSkinRequestedEvent
]

{ #category : #'event handling' }
ToSkin >> dragStartedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> draggedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> droppedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> elementLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> enabledLookEvent: anEvent [


]

{ #category : #'api - accessing' }
ToSkin >> eventsToHandle [

	^ {
		  ToThemeChangedEvent.
		  ToSkinEvent.
		  ToElementLookEvent }
]

{ #category : #'event handling' }
ToSkin >> focusedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> hoveredLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> indeterminateLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> installLookEvent: anEvent [


]

{ #category : #testing }
ToSkin >> isNullSkin [

	^ false
]

{ #category : #'event handling' }
ToSkin >> leavedLookEvent: anEvent [


]

{ #category : #'api - hooks' }
ToSkin >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	" install the event handler that generates state for the state engine"
	anElement skinStateProcessorClass ifNotNil: [ :cls |
		skinStateEngineEpdater := cls new.
		anElement addEventHandler: skinStateEngineEpdater ]
]

{ #category : #'api - hooks' }
ToSkin >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	skinStateEngineEpdater ifNotNil: [
		anElement removeEventHandler: skinStateEngineEpdater.
		skinStateEngineEpdater := nil ]
]

{ #category : #'event handling' }
ToSkin >> openedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> pressedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> releasedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> selectedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> skinChangedEvent: anEvent [

	anEvent currentTarget skinStateQueue skinChangedEvent: anEvent

]

{ #category : #'event handling' }
ToSkin >> skinRequestedEvent: anEvent [

	anEvent currentTarget skinStateQueue skinRequestedEvent: anEvent

]

{ #category : #'event handling' }
ToSkin >> stillHoveredLookEvent: anEvent [

]

{ #category : #'event handling' }
ToSkin >> stillPressedLookEvent: anEvent [

]

{ #category : #'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target installedSkin == self ifFalse: [
		Error signal: 'Baddly installed skin' ].
	target removeEventHandler: self.
	anEvent currentTarget requestSkin
]

{ #category : #'event handling' }
ToSkin >> uncheckedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> unfocusedLookEvent: anEvent [


]

{ #category : #'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]
