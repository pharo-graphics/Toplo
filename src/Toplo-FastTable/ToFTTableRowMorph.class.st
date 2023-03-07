"
I'm a row for a table.
All my work is to keep cells.
"
Class {
	#name : #ToFTTableRowMorph,
	#superclass : #ToFTSelectableMorph,
	#category : #'Toplo-FastTable-Base'
}

{ #category : #'instance creation' }
ToFTTableRowMorph class >> new [
	self error: 'Use #table:'
]

{ #category : #'instance creation' }
ToFTTableRowMorph class >> table: aTableMorph [
	^ self basicNew
		initializeTable: aTableMorph;
		yourself
]

{ #category : #'event handling' }
ToFTTableRowMorph >> handlesMouseOver: evt [
	self table ifNotNil: [ :table | ^ table selectionModeStrategy allowsRowSelection ].
	^ false
]

{ #category : #initialization }
ToFTTableRowMorph >> initialize [
	super initialize.
	self
		clipSubmorphs: true;
		layoutPolicy: ToFTRowLayout new
]

{ #category : #initialization }
ToFTTableRowMorph >> initializeTable: tableMorph [
	self initialize.
	self
		cellInset: tableMorph intercellSpacing";
		layoutInset: tableMorph intercellSpacing".
	self flag: #pharoTodo. "Check if layout inset works better"
]
