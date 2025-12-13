Class {
	#name : #ToTableDivider,
	#superclass : #ToDivider,
	#instVars : [
		'cellIndex',
		'parentTable'
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
ToTableDivider >> dragTarget [
	| containers |
	containers := parentTable header rulerCells.
	^ containers at: cellIndex
]

{ #category : #initialization }
ToTableDivider >> initialize [

	super initialize.
	self vertical: true.
	self elevation: (BlRelativeElevation elevation: 1).
	self addEventHandler: ToTableDividerEventHandler new
]

{ #category : #accessing }
ToTableDivider >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableDivider >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableDivider >> setPositionInTable [
	| cont bnds |
	cont := self dragTarget.
	bnds := cont bounds inParent: parentTable.
	self position: bnds right - self thickness @ 0.0
]
