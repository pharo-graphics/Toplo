Class {
	#name : #ToTableDivider,
	#superclass : #ToDivider,
	#instVars : [
		'columnElementIndex'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableDivider >> columnElementIndex [

	^ columnElementIndex
]

{ #category : #accessing }
ToTableDivider >> columnElementIndex: anIndex [

	columnElementIndex := anIndex
]

{ #category : #initialization }
ToTableDivider >> initialize [

	super initialize.
	self vertical: true.
	self elevation: (BlRelativeElevation elevation: 1)
]

{ #category : #initialization }
ToTableDivider >> setPositionInTable: aTableElement [

	| headerColumnElements element bnds |
	headerColumnElements := aTableElement header headerColumnElements.
	element := headerColumnElements at: columnElementIndex.
	bnds := element bounds inParent: aTableElement.
	self position: bnds right - self thickness @ 0.0
]
