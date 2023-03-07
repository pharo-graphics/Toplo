"
I define a strategy to handle selections. 
The sense of this class is shown in my children: I allow to handle the case of multiple and simple selection in a well designed way, instead using ifs everywhere.
"
Class {
	#name : #ToFTSelectionStrategy,
	#superclass : #Object,
	#instVars : [
		'table'
	],
	#category : #'Toplo-FastTable-Selection'
}

{ #category : #'instance creation' }
ToFTSelectionStrategy class >> table: aFastTableMorph [
	^ self new
		table: aFastTableMorph;
		yourself
]

{ #category : #testing }
ToFTSelectionStrategy >> isMultiple [
	^ self subclassResponsibility
]

{ #category : #testing }
ToFTSelectionStrategy >> isSimple [
	^ self isMultiple not
]

{ #category : #accessing }
ToFTSelectionStrategy >> selectIndex: rowIndex event: event [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTSelectionStrategy >> selectionModeStrategy [
	^ self table selectionModeStrategy
]

{ #category : #accessing }
ToFTSelectionStrategy >> table [
	^ table
]

{ #category : #accessing }
ToFTSelectionStrategy >> table: aTable [
	table := aTable
]

{ #category : #private }
ToFTSelectionStrategy >> toggleIndex: index [
	((self table selectedIndexes includes: index) and: [ self table selectedIndexes size = 1 and: [ self table allowsDeselection ]	"just one selected" ])
		ifTrue: [ self table deselectAll ]
		ifFalse: [ self table selectIndex: index ]
]
