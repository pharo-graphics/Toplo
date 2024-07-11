Class {
	#name : #ToMultiSelectListElement,
	#superclass : #ToSelectListElement,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToMultiSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"
	super applyDataSourceSieveCommand: aDataSourceCommand.
	selectElement checkHideSelectionFromListElement.
	selectElement checkMaxSelectedCountFromListElement.
	" the window can be opened but invisible if opened from the text input element.
	see ToSelectTextInputElement>>onInstalledIn:"
	selectElement currentWindow ifNotNil: [:w | w visibility: BlVisibility visible  ]
]

{ #category : #accessing }
ToMultiSelectListElement >> groupSelecter [

	^ self selecter subSelecterWithId: #group
]

{ #category : #accessing }
ToMultiSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #'accessing - selection' }
ToMultiSelectListElement >> hideSelection [

	self sieve currentDataWithLocalAndOriginalIndexDo: [
		:d
		:localIndex
		:originalIndex |
		(self selectionModel containsIndex: localIndex)
			ifTrue: [ self selectionModel hideIndex: localIndex ]
			ifFalse: [ self selectionModel unhideIndex: localIndex ] ].
	self notifyDataSourceChanged
]

{ #category : #initialization }
ToMultiSelectListElement >> initialize [

	super initialize.
	self
		withSubSelecterWithId: #group
		withEventClass: ToSelectGroupSelectionChangedEvent.
	self selectionMode selectOnMouseDown: true.
	self selectionMode requestFocusOnMouseDown: false
]

{ #category : #accessing }
ToMultiSelectListElement >> selectElement: aSelectElement [

	super selectElement: aSelectElement
]

{ #category : #accessing }
ToMultiSelectListElement >> sieve [

	^ selectElement sieve
]
