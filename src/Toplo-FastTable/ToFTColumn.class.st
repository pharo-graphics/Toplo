"
Description 
------------------
 
I'm a column definition for a fast table.

I keep an id and relevant informations of my behaviour, but this behaviour is better defined in ToFTDataSource>>#headerColumn:

I can have a sorting strategy, by default I uses a null sorting strategy. The datasource can ask to me informations from the current strategy such as an icon to display in the header cell. When the header is clicked, I'll give a datasource to the strategy and ask to sort it.

Examples
--------------------

	ToFTTableMorph new
		extent: 650 @ 500;
		addColumn:
			((ToFTColumn id: 'Icon')
				width: 40;
				yourself);
		addColumn:
			((ToFTColumn id: 'Name')
				sortableOnProperty: #name;
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of methods')
				sortableOnProperty: #numberOfMethods;
				yourself);
		addColumn:
			((ToFTColumn id: 'Number of instance variables')
				sortableOnProperty: #numberOfInstanceVariables;
				yourself);
		dataSource: ToFTExampleClassInfoTableDataSource new;
		selectFirst;
		showFirstSelection;
		beResizable;
		openInWindow
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	id:							<aSymbol>							An id for the column
	sortingStrategy:		<aColumnSortingStrategy>		A subclass of ToFTAbstractColumnSortingStrategy that will manage all the behavior of the table sorting
	width:						<anInteger>						An Integer that represent the width of a column

"
Class {
	#name : #ToFTColumn,
	#superclass : #Object,
	#instVars : [
		'id',
		'width',
		'sortingStrategy'
	],
	#category : #'Toplo-FastTable-Model'
}

{ #category : #'instance creation' }
ToFTColumn class >> id: anObject [
	^ self new
		id: anObject;
		yourself
]

{ #category : #accessing }
ToFTColumn class >> undefinedColumnWidth [
	"This is a contant that defines a column width is undefined, then the layout will try to arrange
	 it by itself."
	^ 0
]

{ #category : #layout }
ToFTColumn >> acquireWidth: anOwnerWidth [
	^ self widthOrUndefined min: anOwnerWidth
]

{ #category : #sorting }
ToFTColumn >> disableSort [
	self sortingStrategy: (ToFTNullColumnSortingStrategy column: self)
]

{ #category : #accessing }
ToFTColumn >> id [
	^ id
]

{ #category : #accessing }
ToFTColumn >> id: anObject [
	id := anObject
]

{ #category : #initialization }
ToFTColumn >> initialize [
	super initialize.
	self disableSort
]

{ #category : #testing }
ToFTColumn >> isSortEnabled [
	^ self sortingStrategy isSortingEnabled
]

{ #category : #initialization }
ToFTColumn >> resetSorting [
	self sortingStrategy reset
]

{ #category : #accessing }
ToFTColumn >> sortDataSource: aDataSource [

	"If other columns are already sorted, we need to reset them."
	(aDataSource table columns copyWithout: self) do: #resetSorting.
	self sortingStrategy sortDataSource: aDataSource
]

{ #category : #sorting }
ToFTColumn >> sortableOnProperty: aProperty [
	self sortingStrategy: (ToFTPropertyColumnSortingStrategy column: self property: aProperty)
]

{ #category : #sorting }
ToFTColumn >> sortableUsing: aSortFunction [
	self sortingStrategy: (ToFTSortFunctionColumnSortingStrategy column: self sortFunction: aSortFunction)
]

{ #category : #accessing }
ToFTColumn >> sortingIcon [
	^ self sortingStrategy sortingIcon
]

{ #category : #accessing }
ToFTColumn >> sortingStrategy [
	^ sortingStrategy
]

{ #category : #accessing }
ToFTColumn >> sortingStrategy: anObject [
	sortingStrategy := anObject
]

{ #category : #accessing }
ToFTColumn >> transform: anObject [
	^ anObject
]

{ #category : #accessing }
ToFTColumn >> width [
	^ width
]

{ #category : #accessing }
ToFTColumn >> width: anObject [
	width := anObject
]

{ #category : #accessing }
ToFTColumn >> widthOrUndefined [
	^ self width ifNil: [ self class undefinedColumnWidth ]
]
