Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectReadOnlyMode >> configureMultiSelectNodeContainer: anElement [

	super configureMultiSelectNodeContainer: anElement.
	select inputTextField beReadonlyWithoutSelection
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> deselectIndex: anIndex [

	select listElement selectionStrategy deselectIndex: anIndex.
]

{ #category : #'instance creation' }
ToSelectReadOnlyMode >> newInputTextField [ 

	| inputTextField |
	inputTextField := super newInputTextField.
	inputTextField beReadonlyWithoutSelection.
	^ inputTextField
]

{ #category : #'api - hooks' }
ToSelectReadOnlyMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.
	select listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | select strategy refreshNodeContainer ]).
	select data: select listElement data.
	select selectionModel: select listElement selectionStrategy selectionModel
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndex: anIndex [

	select isMultipleSelection ifTrue: [ select listElement selectionStrategy deselectAll ].
	select listElement selectionStrategy selectIndex: anIndex
]
