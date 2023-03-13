"
I'm a row for a table.
All my work is to keep cells.
"
Class {
	#name : #ToFTTableRowElement,
	#superclass : #ToFTSelectableElement,
	#category : #'Toplo-FastTable-Base'
}

{ #category : #'instance creation' }
ToFTTableRowElement class >> new [
	self error: 'Use #table:'
]

{ #category : #'instance creation' }
ToFTTableRowElement class >> table: aTableMorph [
	^ self basicNew
		initializeTable: aTableMorph;
		yourself
]

{ #category : #layout }
ToFTTableRowElement >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #'event handling' }
ToFTTableRowElement >> handlesMouseOver: evt [
	self table ifNotNil: [ :table | ^ table selectionModeStrategy allowsRowSelection ].
	^ false
]

{ #category : #initialization }
ToFTTableRowElement >> initialize [
	super initialize.
	self layout: self defaultLayout.
	self fitContent 
]

{ #category : #initialization }
ToFTTableRowElement >> initializeTable: tableMorph [
	self initialize
]
