Class {
	#name : #ToSelectEditableMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'filter'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectEditableMode >> configureMultiSelectNodeContainer: anElement [

	super configureMultiSelectNodeContainer: anElement.
	select textField requestFocus
]

{ #category : #initialization }
ToSelectEditableMode >> configureSelect [

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

{ #category : #accessing }
ToSelectEditableMode >> dataFilter: aValuable [

	filter dataFilter: aValuable
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> deselectIndex: anIndex [

	select selectionModel deselectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]

{ #category : #private }
ToSelectEditableMode >> filterString [

	^ select textField text asString
]

{ #category : #private }
ToSelectEditableMode >> filterTextFieldUpdated: anEvent [

	select listElement dispatchEvent:
		(ToListFilterRequest new pattern: self filterString)
]

{ #category : #testing }
ToSelectEditableMode >> isEditableMode [

	^ true
]

{ #category : #'api - hooks' }
ToSelectEditableMode >> onUninstalledIn: aSelect [

	filter onUninstalledIn: select  listElement.
	filter := nil.
	super onUninstalledIn: aSelect.
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> selectIndex: anIndex [

	select selectionModel selectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]

{ #category : #'accessing selection' }
ToSelectEditableMode >> selectIndexes: aCollection [

	select selectionModel selectIndexes: aCollection.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]
