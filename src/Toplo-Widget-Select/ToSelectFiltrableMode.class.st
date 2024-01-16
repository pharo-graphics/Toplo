Class {
	#name : #ToSelectFiltrableMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'filter'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectFiltrableMode >> configureMultiSelectNodeContainer: anElement [

	super configureMultiSelectNodeContainer: anElement.
	select textField requestFocus
]

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

{ #category : #private }
ToSelectFiltrableMode >> filterString [

	^ select textField text asString
]

{ #category : #private }
ToSelectFiltrableMode >> filterTextFieldUpdated: anEvent [

	select listElement dispatchEvent:
		(ToListFilterRequest new pattern: self filterString)
]

{ #category : #testing }
ToSelectFiltrableMode >> isFiltrableMode [

	^ true
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	select listElement addEventHandler: (ToSelectListEventHandler new
			 select: select;
			 yourself).

	select data addEventHandler: (BlEventHandler
			 on: ToCollectionAfterChangeEvent
			 do: [ select listElement data updateAllWith: select data ]).

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
	filter := nil.
	super onUninstalledIn: aSelect.
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> selectIndex: anIndex [

	select selectionModel selectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]
