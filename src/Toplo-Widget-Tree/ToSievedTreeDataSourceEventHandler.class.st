Class {
	#name : #ToSievedTreeDataSourceEventHandler,
	#superclass : #ToSievedListDataSourceEventHandler,
	#category : #'Toplo-Widget-Tree-Sieve'
}

{ #category : #'data source events handling' }
ToSievedTreeDataSourceEventHandler >> buildOriginalIndexMap [

	originalIndexMap removeAll.
	sieveSelectionModel deselectAll.
	listElement postponeAction: [
			| roots |
			roots := listElement dataSource select: [ :w | w isRoot ].
			roots withIndexDo: [ :aData :idx |
				originalIndexMap at: aData put: idx ].
			sieveSelectionModel copySelectionFrom: listElement selectionModel ]
]
