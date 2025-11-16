Class {
	#name : #ToTableColumnHeaderElement,
	#superclass : #ToTripletElement,
	#instVars : [
		'column'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableColumnHeaderElement class >> column: aColumn [

	^ self new
		  column: aColumn;
		  yourself
]

{ #category : #accessing }
ToTableColumnHeaderElement >> column [

	^ column
]

{ #category : #accessing }
ToTableColumnHeaderElement >> column: aTableColumn [

	column := aTableColumn.
	self updateColumn
]

{ #category : #initialization }
ToTableColumnHeaderElement >> initialize [

	super initialize.
	self id: #headerColumn.
	self
		hMatchParent;
		vFitContent
]

{ #category : #updating }
ToTableColumnHeaderElement >> updateArrowOrientation: arrow [

	self column sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self column sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
]

{ #category : #updating }
ToTableColumnHeaderElement >> updateColumn [

	column buildHeaderView: self middleContainer.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column sorterBlock ifNotNil: [
			| arrow |
			arrow := ToIconicArrowButton new.
			self startElement: arrow.
			self updateArrowOrientation: arrow.
			self startElement clickAction: [
					column nextSort.
					self updateArrowOrientation: arrow.
					self startElement fireEvent: (ToSortColumn column: column) ] ]
]

{ #category : #accessing }
ToTableColumnHeaderElement >> updateWidthWith: aNumber [

	self width: aNumber.
	self column width: aNumber.

]
