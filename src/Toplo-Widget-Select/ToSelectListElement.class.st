Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'selectElement'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"
	super applyDataSourceSieveCommand: aDataSourceCommand.
	" the window can be opened but invisible if opened from the text input element.
	see ToSelectTextInputElement>>onInstalledIn:"
	selectElement currentWindow ifNotNil: [:w | w visibility: BlVisibility visible  ]
]

{ #category : #accessing }
ToSelectListElement >> groupSelecter [

	^ self selecter subSelecterWithId: #group
]

{ #category : #accessing }
ToSelectListElement >> groupSelectionModel [

	^ self groupSelecter selectionModel
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	self newUnselectableSelectionMode onInstalledIn: self.
	self newHiddenSelectionMode onInstalledIn: self.
	self newDisabledSelectionMode onInstalledIn: self.
	self
		withSubSelecterWithId: #group
		withEventClass: ToSelectGroupSelectionChangedEvent.

	self selectionMode selectOnMouseDown: true.
	self selectionMode requestFocusOnMouseDown: false
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #accessing }
ToSelectListElement >> selectElement: aSelectElement [

	selectElement := aSelectElement
]

{ #category : #accessing }
ToSelectListElement >> sieve [

	^ selectElement sieve
]
