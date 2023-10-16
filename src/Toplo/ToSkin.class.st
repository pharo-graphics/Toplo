Class {
	#name : 'ToSkin',
	#superclass : 'BlCustomEventHandler',
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
ToSkin >> disabledLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> elementLookEvent: anEvent [


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

	anEvent target switchToSkinState: ToInstallState new.
	anEvent target isDisabled ifTrue: [
		^ anEvent target switchToSkinState: ToDisabledState new ].
	anEvent target switchToSkinState: ToInitialState new
]

{ #category : 'event handling' }
ToSkin >> themeChangedEvent: anEvent [

	anEvent currentTarget requestSkin 
]

{ #category : 'event handling' }
ToSkin >> uncheckedLookEvent: anEvent [


]

{ #category : 'event handling' }
ToSkin >> uninstallLookEvent: anEvent [


]
