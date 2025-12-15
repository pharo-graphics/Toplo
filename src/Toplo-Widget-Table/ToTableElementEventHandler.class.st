Class {
	#name : #ToTableElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'event handling' }
ToTableElementEventHandler >> addedToSpaceEvent: anEvent [

	| table |
	table := anEvent currentTarget.
	table header whenLayoutedDoOnce: [ table recordCellsWidth ]
]

{ #category : #'api - accessing' }
ToTableElementEventHandler >> eventsToHandle [

	^ { ToAddedToSpaceEvent. ToTableColumnSortRequestEvent }
]

{ #category : #'event handling' }
ToTableElementEventHandler >> tableColumnSortRequestEvent: anEvent [

	| sortFunctions columns table |
	"I sort the data based on the information in the column configuration.
	for now sort by column from left to right. Future should implement an order of sorting"
	table := anEvent currentTarget.
	columns := table columns.
	sortFunctions := (columns
		                  select: [ :col |
		                  col sortOrder isNotNil and: [
			                  col sorterBlock isNotNil ] ]
		                  thenCollect: [ :col |
				                  | f |
				                  "reverse sort function in case of descending"
				                  f := col sorterBlock asSortFunction.
				                  col sortOrder = #descending ifFalse: [
					                  f := f reversed ].
				                  col -> f ]) asDictionary.
	table updateSelectionAfter: [
			sortFunctions keysAndValuesDo: [ :keyColumn :valueSortFunction |
					table dataAccessor sort: [ :item1 :item2 |
						valueSortFunction value: item1 value: item2 ] ] ]
]
