Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionFilteredEvent: anEvent [

	| select |
	select := windowManager element.
	windowManager currentWindow ifNil: [
		select strategy textInputElement filterString ifNotEmpty: [
			select popupWindowEvent: anEvent ] ]
]

{ #category : #'element handlers' }
ToSelectEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	anEvent currentTarget notifySelectionChanged
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

	self showHidePlaceholderIn: anEvent currentTarget
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectSelectionChanged: anEvent [

	anEvent currentTarget listElement dataSource notifyChanged.
	anEvent currentTarget strategy refreshHeaderNodeContainer.
	self showHidePlaceholderIn: anEvent currentTarget.
]

{ #category : #'element handlers' }
ToSelectEventHandler >> showHidePlaceholderIn: aSelect [

	aSelect selectionModel ifEmpty: [
		aSelect inputTextField text ifEmpty: [
			^ aSelect headerElement showPlaceholder ] ].
	aSelect headerElement hidePlaceholder
]
