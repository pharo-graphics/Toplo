Class {
	#name : #ToSelectReadOnlyMode,
	#superclass : #ToSelectMode,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectReadOnlyMode >> configureMultiSelectNodeContainer: anElement [

	super configureMultiSelectNodeContainer: anElement.
	select textField beReadonlyWithoutSelection
]

{ #category : #initialization }
ToSelectReadOnlyMode >> configureSelect [

	select listElement addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | select strategy refreshNodeContainer ]).
	select data: select listElement data.
	select selectionModel:
		select listElement selectionStrategy selectionModel
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> deselectIndex: anIndex [

	select listElement selectionStrategy deselectIndex: anIndex.
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndex: anIndex [

	select listElement selectionStrategy selectIndex: anIndex
]

{ #category : #'accessing selection' }
ToSelectReadOnlyMode >> selectIndexes: aCollection [

	select listElement selectionStrategy selectIndexes: aCollection
]
