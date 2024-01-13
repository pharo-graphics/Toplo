Class {
	#name : #ToFilteredListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'filter',
		'updatingSelection',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'api - accessing' }
ToFilteredListElementEventHandler >> eventsToHandle [

	^ {
		  ToListFilterRequest.
		  ToListFilterResultEvent.
		  ToListSelectionChangedEvent.
		  ToFilteredListSelectionModelChangedEvent }
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> filter: aListElementFilter [

	filter := aListElementFilter
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> filteredListSelectionModelChangedEvent: anEvent [

	| target selectedIndexes deselectedIndexes |
	target := anEvent currentTarget.
	selectedIndexes := OrderedCollection new.
	deselectedIndexes := OrderedCollection new.
	updatingSelection := true.

	filter indexedData withIndexDo: [ :idata :idx |
		(self selectionModel containsIndex: idata dataSourcePos)
			ifTrue: [ selectedIndexes add: idx ]
			ifFalse: [ deselectedIndexes add: idx ] ].

	target selectionStrategy deselectAll.
	target selectionStrategy selectIndexes: selectedIndexes.
	self flag: 'TODO: check with <target selectionStrategy deselectIndexes: deselectedIndexes.>. I''m not sure it works ( and it must work ) but now its time to go to sleep... '.
	
	updatingSelection := false
]

{ #category : #initialization }
ToFilteredListElementEventHandler >> initialize [

	super initialize.
	updatingSelection := false
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> listFilterRequest: anEvent [

	| target |
	target := anEvent currentTarget.
	filter pattern: anEvent pattern
	
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> listFilterResultEvent: anEvent [

	| target selectedIndexes |
	target := anEvent currentTarget.
	target selectionStrategy renewSelectionModel.
	updatingSelection := true.
	target data filterResult:
		(anEvent indexedData collect: [ :id | id data ]).
	selectedIndexes := OrderedCollection new.
	anEvent indexedData withIndexDo: [ :id :idx |
		(self selectionModel containsIndex: id dataSourcePos) ifTrue: [
			selectedIndexes add: idx ] ].
	target selectionStrategy doSelectAllIndexes: selectedIndexes.
	updatingSelection := false
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> listSelectionChangedEvent: anEvent [
	" launched when the list element is clicked. 
	invoked from the list element selection strategy "

	| target |
	updatingSelection ifTrue: [ ^ self ].
	filter indexedData ifNil: [ ^ self ].
	target := anEvent currentTarget.
	" the target is the filtered listElement "

	1 to: target data size do: [ :pos |
		| dataWithIndex |
		dataWithIndex := filter indexedData at: pos.
		(target selectionStrategy includes: pos)
			ifTrue: [ self selectionModel selectIndex: dataWithIndex dataSourcePos ]
			ifFalse: [ self selectionModel deselectIndex: dataWithIndex dataSourcePos ] ].

	target dispatchEvent: (ToFilteredListSelectionChangedEvent new
			 selection: self selectionModel;
			 yourself)
]

{ #category : #'api - hooks' }
ToFilteredListElementEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	filter := nil.
	selectionModel := nil

]

{ #category : #accessing }
ToFilteredListElementEventHandler >> selectionModel [

	^ selectionModel 
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
