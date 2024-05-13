Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"
	super applyDataSourceSieveCommand: aDataSourceCommand.
	select checkHideSelectionFromListElement.
	select checkMaxSelectedCountFromListElement.
	" the window can be invisible if opened from the text input element 
	to ensure that the sieve is applied before being visible
	see ToSelectTextInputElement>>onInstalledIn:"
	select currentWindow ifNotNil: [:w | w visibility: BlVisibility visible  ]
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
	self withUnselectableSelecter.
	self withHiddenSelecter.
	self withDisabledSelecter.
	self
		withAdditionalSelecterWithId: #group
		withEventClass: ToSelectGroupSelectionChangedEvent.
	self selectionMode selectOnMouseDown: true.
	self selectionMode requestFocusOnMouseDown: false
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #accessing }
ToSelectListElement >> select [

	^ select
]

{ #category : #accessing }
ToSelectListElement >> select: aSelect [

	select := aSelect
]
