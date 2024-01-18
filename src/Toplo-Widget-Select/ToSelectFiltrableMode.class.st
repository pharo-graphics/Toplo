Class {
	#name : #ToSelectFiltrableMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'filter'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectFiltrableMode >> configureMonoSelectNodeContainer: anElement [

	super configureMonoSelectNodeContainer: anElement
]

{ #category : #initialization }
ToSelectFiltrableMode >> configureMultiSelectNodeContainer: anElement [

	super configureMultiSelectNodeContainer: anElement.
	select inputTextField requestFocus
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
	select listElement addEventHandler: (ToSelectFiltrableListEventHandler new
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
	filter := nil.
	super onUninstalledIn: aSelect.
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> selectIndex: anIndex [

	select isMultipleSelection ifTrue: [ select selectionModel deselectAll ].
	select selectionStrategy selectIndex: anIndex.
	select listElement dispatchEvent:
		(ToFilteredListSelectionModelChangedEvent new
			 selection: select selectionModel;
			 yourself)
]
