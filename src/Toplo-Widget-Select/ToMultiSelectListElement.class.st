Class {
	#name : #ToMultiSelectListElement,
	#superclass : #ToSelectListElement,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToMultiSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"
	super applyDataSourceSieveCommand: aDataSourceCommand.
	select checkHideSelectionFromListElement.
	select checkMaxSelectedCountFromListElement.
	" the window can be opened but invisible if opened from the text input element.
	see ToSelectTextInputElement>>onInstalledIn:"
	select currentWindow ifNotNil: [:w | w visibility: BlVisibility visible  ]
]

{ #category : #accessing }
ToMultiSelectListElement >> groupSelecter [

	^ self selecter subSelecterWithId: #group
]

{ #category : #accessing }
ToMultiSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToMultiSelectListElement >> initialize [

	super initialize.
	self
		withAdditionalSelecterWithId: #group
		withEventClass: ToSelectGroupSelectionChangedEvent.
	self selectionMode selectOnMouseDown: true.
	self selectionMode requestFocusOnMouseDown: false
]

{ #category : #accessing }
ToMultiSelectListElement >> selectElement: aSelectElement [

	super selectElement: aSelectElement.
	self addEventHandler: (ToMultiSelectSelectionObserver new
			 selectElement: aSelectElement;
			 yourself)
]
