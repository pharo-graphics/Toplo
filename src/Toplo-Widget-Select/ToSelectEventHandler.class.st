Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionFilteredEvent: anEvent [

	| select |
	select := anEvent currentTarget.

	windowManager currentWindow ifNil: [
		select textInputElement filterString ifNotEmpty: [
			select popupWindowEvent: anEvent ] ]
]

{ #category : #'element handlers' }
ToSelectEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| select |
	select := anEvent currentTarget.
	select notifySelectionChanged 
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
		  ToSelectSelectionChanged.
		  ToCollectionFilteredEvent.
		  BlElementExtentChangedEvent.
		  ToSelectInputTextFieldUpdatedEvent }
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectInputTextFieldUpdatedEvent: anEvent [

	anEvent currentTarget showHidePlaceholder.
	anEvent currentTarget filterStringChanged.
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectSelectionChanged: anEvent [

	| select |
	select := anEvent currentTarget.
	select showHidePlaceholder.
	select onSelectionChanged.
	anEvent consume
]

{ #category : #'event handling' }
ToSelectEventHandler >> windowClosedEvent: anEvent [

	super windowClosedEvent: anEvent.
	anEvent currentTarget iconContainer dispatchEvent: anEvent
]

{ #category : #'event handling' }
ToSelectEventHandler >> windowOpenedEvent: anEvent [

	super windowOpenedEvent: anEvent.
	anEvent currentTarget iconContainer dispatchEvent: anEvent
]
