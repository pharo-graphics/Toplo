Class {
	#name : #ToTableDivider,
	#superclass : #ToDivider,
	#instVars : [
		'cellIndex'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableDivider >> cellIndex [

	^ cellIndex
]

{ #category : #accessing }
ToTableDivider >> cellIndex: anIndex [

	cellIndex := anIndex
]

{ #category : #initialization }
ToTableDivider >> initialize [

	super initialize.
	self vertical: true.
	self elevation: (BlRelativeElevation elevation: 1)
]

{ #category : #initialization }
ToTableDivider >> setPositionInTable: aTableElement [

	| headerCells cell bnds |
	headerCells := aTableElement header cells.
	cell := headerCells at: cellIndex.
	bnds := cell bounds inParent: aTableElement.
	self position: bnds right - self thickness @ 0.0
]
