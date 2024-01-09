Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'element handlers' }
ToSelectEventHandler >> dataFilterResultEvent: anEvent [

	anEvent currentTarget windowManager filterResult: anEvent
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
		  ToDataFilterResultEvent.
		  BlElementExtentChangedEvent.
		  ToSelectDataAddedEvent.
		  ToListSelectionChangedEvent }
]

{ #category : #'element handlers' }
ToSelectEventHandler >> listSelectionChangedEvent: anEvent [

	anEvent currentTarget refreshNodes
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectDataAddedEvent: anEvent [

	anEvent currentTarget selectIndex: anEvent index.
	anEvent currentTarget refreshNodes
]
