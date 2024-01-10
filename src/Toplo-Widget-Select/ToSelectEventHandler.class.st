Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionAddEvent: anEvent [

	anEvent currentTarget updateDataIndex
]

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionFilterEvent: anEvent [

	" ignored "
]

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionRemoveEvent: anEvent [

	anEvent currentTarget updateDataIndex
]

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionUpdateAllEvent: anEvent [

	anEvent currentTarget updateDataIndex
]

{ #category : #'element handlers' }
ToSelectEventHandler >> collectionUpdateEvent: anEvent [

	anEvent currentTarget updateDataIndex
]

{ #category : #'element handlers' }
ToSelectEventHandler >> dataFilterResultEvent: anEvent [

	anEvent currentTarget windowManager filterResultEvent: anEvent
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
		  ToCollectionAfterChangeEvent }
]

{ #category : #'element handlers' }
ToSelectEventHandler >> listSelectionChangedEvent: anEvent [

	anEvent currentTarget
		selectIndexes: anEvent currentIndexes;
		refreshNodes
]

{ #category : #'element handlers' }
ToSelectEventHandler >> selectDataAddedEvent: anEvent [

	anEvent currentTarget selectIndex: anEvent index.
	anEvent currentTarget refreshNodes
]
