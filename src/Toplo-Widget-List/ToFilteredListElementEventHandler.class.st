Class {
	#name : #ToFilteredListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'filter',
		'updatingSelection',
		'selection'
	],
	#category : #'Toplo-Widget-List-Filter'
}

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> collectionUpdateAllRequest: anEvent [

]

{ #category : #'api - accessing' }
ToFilteredListElementEventHandler >> eventsToHandle [

	^ {
		  ToCollectionUpdateAllRequest.
		  ToListFilterRequest.
		  ToListFilterResultEvent.
		  ToListSelectionChangedEvent.
		  ToFilteredListSelectionModelChangedEvent }
]

{ #category : #'event handlers' }
ToFilteredListElementEventHandler >> filteredListSelectionModelChangedEvent: anEvent [

	| target selectedIndexes deselectedIndexes |
	target := anEvent currentTarget.
	selectedIndexes := OrderedCollection new.
	deselectedIndexes := OrderedCollection new.
	updatingSelection := true.

	filter indexedData withIndexDo: [ :idata :idx |
		(self selection containsIndex: idata dataSourcePos)
			ifTrue: [ selectedIndexes add: idx ]
			ifFalse: [ deselectedIndexes add: idx ] ].

	target selectionStrategy selectIndexes: selectedIndexes.
	target selectionStrategy deselectIndexes: deselectedIndexes.
	updatingSelection := false
]

{ #category : #initialization }
ToFilteredListElementEventHandler >> initialize [

	super initialize.
	updatingSelection := false.
	filter := ToListElementFilter new
	
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
		(self selection containsIndex: id dataSourcePos) ifTrue: [
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
			ifTrue: [ self selection selectIndex: dataWithIndex dataSourcePos ]
			ifFalse: [
			self selection deselectIndex: dataWithIndex dataSourcePos ] ].

	target dispatchEvent: (ToFilteredListSelectionChangedEvent new
			 selection: self selection;
			 yourself)
]

{ #category : #'api - hooks' }
ToFilteredListElementEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	filter onInstalledIn: anElement
]

{ #category : #'api - hooks' }
ToFilteredListElementEventHandler >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	filter onUninstalledIn: anElement.
	filter := nil.
	selection := nil

]

{ #category : #accessing }
ToFilteredListElementEventHandler >> originalData [

	
	^ filter originalData
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> originalData: anObservableCollection [

	filter originalData: anObservableCollection  
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> selection [

	^ selection ifNil: [ selection := BlCompositeSelection new ]
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> selection: aSelectionModel [

	selection := aSelectionModel
]

{ #category : #accessing }
ToFilteredListElementEventHandler >> taskQueueHolder: aTaskQueueHolder [

	filter taskQueueHolder: aTaskQueueHolder

]
