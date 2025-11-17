Class {
	#name : #ToTableHeaderCellElement,
	#superclass : #ToTableCellElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderCellElement >> initialize [

	super initialize.
	self id: #headerCell
]

{ #category : #updating }
ToTableHeaderCellElement >> initializeFromColumn [

	innerElement := ToTripletElement new.
	innerElement
		hMatchParent;
		vFitContent.
	self addChild: innerElement.
	column buildHeaderView: innerElement middleContainer.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column sorterBlock ifNotNil: [
			| arrow |
			arrow := ToIconicArrowButton new.
			innerElement startElement: arrow.
			self updateArrowOrientation: arrow.
			innerElement startElement clickAction: [
					column nextSort.
					self updateArrowOrientation: arrow.
					innerElement startElement fireEvent:
						(ToSortColumn column: column) ] ]
]

{ #category : #updating }
ToTableHeaderCellElement >> updateArrowOrientation: arrow [

	self column sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self column sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
]

{ #category : #accessing }
ToTableHeaderCellElement >> updateWidthWith: aNumber [

	super updateWidthWith: aNumber.
	self column width: aNumber.

]
