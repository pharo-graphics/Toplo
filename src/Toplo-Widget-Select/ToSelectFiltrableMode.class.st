Class {
	#name : #ToSelectFiltrableMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'filter',
		'filtrableListEventHandler',
		'dataCollectionAfterChangeEventHandler'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectFiltrableMode >> dataFilter: aValuable [

	filter dataFilter: aValuable
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> deselectIndex: anIndex [

	select selectionModel deselectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]

{ #category : #testing }
ToSelectFiltrableMode >> isFiltrableMode [

	^ true
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	filtrableListEventHandler := ToSelectFiltrableListEventHandler new
			 select: select;
			 yourself.

	dataCollectionAfterChangeEventHandler := BlEventHandler
			 on: ToCollectionAfterChangeEvent
			 do: [ select listElement data updateAllWith: select data ].
	
	select listElement addEventHandler: filtrableListEventHandler.
	select data addEventHandler: dataCollectionAfterChangeEventHandler.

	select selectionModel: BlCompositeSelection new.
	filter := ToListElementFilter new.
	filter taskQueueHolder: select.
	filter originalData: select data.
	filter selectionModel: select selectionModel.
	filter onInstalledIn: select listElement
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onUninstalledIn: aSelect [

	filter onUninstalledIn: select  listElement.
	select listElement removeEventHandler: filtrableListEventHandler.
	select data removeEventHandler: dataCollectionAfterChangeEventHandler.
	select selectionModel: nil.
	filtrableListEventHandler := nil.
	dataCollectionAfterChangeEventHandler := nil.
	filter := nil.

	super onUninstalledIn: aSelect.
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> selectIndex: anIndex [

	select listElement selectionStrategy selectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]
