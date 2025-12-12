Class {
	#name : #ToTableHeaderNodeContainerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #sorting }
ToTableHeaderNodeContainerEventHandler >> columnSortRequestEvent: anEvent [

	| sortFunctions columns table header |
	"I sort the data based on the information in the column configuration.
	for now sort by column from left to right. Future should implement an order of sorting"
	header := anEvent currentTarget.
	table := header parentTable.
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

{ #category : #'api - accessing' }
ToTableHeaderNodeContainerEventHandler >> eventsToHandle [
	^  { ToTableSortRequestEvent }
]
