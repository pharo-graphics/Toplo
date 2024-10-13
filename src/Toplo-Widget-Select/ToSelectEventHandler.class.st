Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'event handling' }
ToSelectEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| select |
	select := anEvent currentTarget.
	select refresh 
]

{ #category : #'element handlers' }
ToSelectEventHandler >> elementExtentChangedEvent: anEvent [

	windowManager currentWindow ifNil: [ ^ self ].
	windowManager applyPositionHookFromEvent: anEvent.
	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToSelectEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  BlElementAddedToSceneGraphEvent.
		  BlElementExtentChangedEvent.
		  ToSelectInputTextFieldUpdatedEvent }
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectInputTextFieldUpdatedEvent: anEvent [

	anEvent currentTarget filterStringChanged.
]
