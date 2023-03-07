"
Description
--------------------

I am an abstract classes to define the API of FastTable column sorting strategies. 

My subclasses will implement different way to sort a FastTable.

I am linked to a ToFTColumn implementing the Strategy design pattern.

Public API and Key Messages
--------------------

- #isSortingEnable 		Return a boolean to know if the sorting through this column is currently enabled.
- #sortDatasource: 		Sort a datasource depending on my state. This behavior will be defined by my subclasses.
- #sortingIcon 				Return an icon that can be displayed in the header cell to indicated in which state we are.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	column:		<aToFTColumn>	 The column using me to sort its table.

"
Class {
	#name : #ToFTAbstractColumnSortingStrategy,
	#superclass : #Object,
	#instVars : [
		'column'
	],
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #accessing }
ToFTAbstractColumnSortingStrategy class >> column: aColumn [
	^ self new
		column: aColumn;
		yourself
]

{ #category : #accessing }
ToFTAbstractColumnSortingStrategy >> column [
	^ column
]

{ #category : #accessing }
ToFTAbstractColumnSortingStrategy >> column: anObject [
	column := anObject
]

{ #category : #testing }
ToFTAbstractColumnSortingStrategy >> isSortingEnabled [
	^ true
]

{ #category : #accessing }
ToFTAbstractColumnSortingStrategy >> morphicIconNamed: aString [
	^ (self iconNamed: aString) asMorph
]

{ #category : #initialization }
ToFTAbstractColumnSortingStrategy >> reset [
	self subclassResponsibility
]

{ #category : #sorting }
ToFTAbstractColumnSortingStrategy >> sortDataSource: aDataSource [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTAbstractColumnSortingStrategy >> sortingIcon [
	^ self subclassResponsibility
]
