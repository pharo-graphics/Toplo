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

{ #category : #initialization }
ToSelectFiltrableMode >> configureMultiSelectNodeContainer: aSelectHeaderNodeContainer [

	super configureMultiSelectNodeContainer: aSelectHeaderNodeContainer.
	select inputTextField requestFocus
]

{ #category : #accessing }
ToSelectFiltrableMode >> dataFilter: aValuable [

	filter dataFilter: aValuable
]

{ #category : #initialization }
ToSelectFiltrableMode >> defaultMonoSelectHeaderNodeClass [

	^ ToFiltrableSelectHeaderNode
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

	^ select inputTextField text asString
]

{ #category : #private }
ToSelectFiltrableMode >> filterTextFieldUpdated: anEvent [

	select listElement dispatchEvent:
		(ToListFilterRequest new pattern: self filterString).
	select strategy filterTextFieldUpdated: anEvent
]

{ #category : #testing }
ToSelectFiltrableMode >> isFiltrableMode [

	^ true
]

{ #category : #'instance creation' }
ToSelectFiltrableMode >> newInputTextField [

	| inputTextField |
	inputTextField := super newInputTextField.
	inputTextField addEditorShortcut:
		ToSelectTextFieldBackspaceShortcut new.
	inputTextField addEditorShortcut:
		ToSelectTextFieldCarriageReturnShortcut new.
	inputTextField addEventHandler: (BlEventHandler
			 on: AlbTextEditedEvent
			 do: [ :event | self filterTextFieldUpdated: event ]).
	inputTextField addEventHandler: (BlEventHandler
			 on: AlbTextReplacedEvent
			 do: [ :event |
				 select inputTextField ifNotNil: [
					 self filterTextFieldUpdated: event ] ]).
	^ inputTextField
]

{ #category : #'instance creation' }
ToSelectFiltrableMode >> newSelectedDataTextField [
	" used for mono selection strategy only "

	| textField |
	textField := self newTextField.
	^ textField
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

{ #category : #'accessing list' }
ToSelectFiltrableMode >> onListClosed [

	select inputTextField requestFocus.
]

{ #category : #'accessing list' }
ToSelectFiltrableMode >> onListOpened [

	select inputTextField requestFocus.
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
