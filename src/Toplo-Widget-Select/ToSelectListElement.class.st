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
	" the window can be opened but invisible if opened from the text input element.
	see ToSelectTextInputElement>>onInstalledIn:"
	select currentWindow ifNotNil: [:w | w visibility: BlVisibility visible  ]
]

{ #category : #initialization }
ToSelectListElement >> initialize [

	super initialize.
	self withUnselectableSelecter.
	self withHiddenSelecter.
	self withDisabledSelecter.
	self selectionMode selectOnMouseDown: true.
	self selectionMode requestFocusOnMouseDown: false
]

{ #category : #skin }
ToSelectListElement >> newRawSkin [ 

	^ ToBasicListElementSkin new
]

{ #category : #accessing }
ToSelectListElement >> selectElement: aSelectElement [

	select := aSelectElement
]
