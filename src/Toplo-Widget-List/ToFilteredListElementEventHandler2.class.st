Class {
	#name : #ToFilteredListElementEventHandler2,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'filter',
		'updatingSelection'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'api - accessing' }
ToFilteredListElementEventHandler2 >> eventsToHandle [

	^ {
		  ToListFilterRequest.
		  ToListFilterResultEvent.
		  ToListSelectionChangedEvent.
		  ToFilteredListSelectionModelChangedEvent }
]

{ #category : #accessing }
ToFilteredListElementEventHandler2 >> filter: aListElementFilter [

	filter := aListElementFilter
]

{ #category : #accessing }
ToFilteredListElementEventHandler2 >> filteredListElement [ 

	^ filter filteredListElement
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler2 >> filteredListSelectionModelChangedEvent: anEvent [

	| target selectedIndexes deselectedIndexes |
	target := anEvent currentTarget.
	selectedIndexes := OrderedCollection new.
	deselectedIndexes := OrderedCollection new.
	updatingSelection := true.

	filter currentIndexedData withIndexDo: [ :idata :idx |
		(self selectionModel containsIndex: idata dataSourcePos)
			ifTrue: [ selectedIndexes add: idx ]
			ifFalse: [ deselectedIndexes add: idx ] ].

	target selectionStrategy deselectAll.
	target selectionStrategy selectIndexes: selectedIndexes.
	self flag: 'TODO: check with <target selectionStrategy deselectIndexes: deselectedIndexes.>. I''m not sure it works ( and it must work ) but now its time to go to sleep... '.
	
	updatingSelection := false
]

{ #category : #initialization }
ToFilteredListElementEventHandler2 >> initialize [

	super initialize.
	updatingSelection := false
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler2 >> listFilterRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	filter pattern: anEvent pattern
	
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler2 >> listFilterResultEvent: anEvent [

	| target selectedIndexes result |
	target := anEvent currentTarget.
	" target is the filtered listElement (pattern dependent) "
	" selectionModel is the original (global, pattern independent) selection model "
	target selectionStrategy renewSelectionModel.
	updatingSelection := true.
	" result is the filter result data list (pattern dependent)"
	result := OrderedCollection new.
	"  selected indexes is for the filtered list (pattern dependent) "
	selectedIndexes := OrderedCollection new.
	" anEvent indexedData : list of ToFilterData, (pattern dependent"
	anEvent indexedData withIndexDo: [ :id :idx |
		result add: id data.
		"dataSourcePos is the original data index (pattern independent)"
		(self filteredListElement selectionStrategy selectionModel containsIndex: id dataSourcePos) ifTrue: [
			selectedIndexes add: idx ] ].
	target data filterResult: result.
	target selectionStrategy doSelectAllIndexes: selectedIndexes.
	updatingSelection := false
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler2 >> listSelectionChangedEvent: anEvent [
	" launched when the list element is clicked. 
	invoked from the list element selection strategy "

	| target filteredListElementSelectionModel  |
	updatingSelection ifTrue: [ ^ self ].
	filter currentIndexedData ifNil: [ ^ self ].
	target := anEvent currentTarget.
	filteredListElementSelectionModel := self filteredListElement selectionStrategy selectionModel.

	" the target is the filtered listElement "
	1 to: target data size do: [ :pos |
		| dataWithIndex |
		dataWithIndex := filter currentIndexedData at: pos.
		(target selectionStrategy includes: pos)
			ifTrue: [ filteredListElementSelectionModel selectIndex: dataWithIndex dataSourcePos ]
			ifFalse: [ filteredListElementSelectionModel deselectIndex: dataWithIndex dataSourcePos ] ].

	target dispatchEvent: (ToFilteredListSelectionChangedEvent new
			 selection: filteredListElementSelectionModel;
			 yourself)
]

{ #category : #'api - hooks' }
ToFilteredListElementEventHandler2 >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	filter := nil.
]

{ #category : #accessing }
ToFilteredListElementEventHandler2 >> selectionModel [

	^ filter selectionModel 
]
