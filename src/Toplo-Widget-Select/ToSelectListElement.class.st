Class {
	#name : #ToSelectListElement,
	#superclass : #ToListElement,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #'private - commands' }
ToSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"
	super applyDataSourceSieveCommand: aDataSourceCommand.
	select checkHideSelectionFromListElement.
	select checkMaxSelectedCountFromListElement.
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
		withEventClass: ToSelectGroupSelectionChangedEvent
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
