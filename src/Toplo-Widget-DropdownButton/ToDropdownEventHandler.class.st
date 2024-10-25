Class {
	#name : #ToDropdownEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-DropdownButton'
}

{ #category : #'event handling' }
ToDropdownEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| select |
	select := anEvent currentTarget.
	select refresh 
]

{ #category : #'element handlers' }
ToDropdownEventHandler >> elementExtentChangedEvent: anEvent [

	windowManager currentWindow ifNil: [ ^ self ].
	windowManager applyPositionHookFromEvent: anEvent.
	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToDropdownEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementAddedToSceneGraphEvent.
		  BlElementExtentChangedEvent }
]
