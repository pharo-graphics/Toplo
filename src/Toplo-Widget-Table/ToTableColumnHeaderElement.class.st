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
ToTableColumnHeaderElement >> column: anObject [

	column := anObject.
	self updateColumn
]

{ #category : #initialization }
ToTableColumnHeaderElement >> initialize [

	| label |
	super initialize.
	self
		hMatchParent;
		vFitContent.
	label := ToTableHeaderLabelElement new
		         id: #label;
		         yourself.
	self middleElement: label
]

{ #category : #updating }
ToTableColumnHeaderElement >> updateArrowOrientation: arrow [

	self column sortOrder = #ascending ifTrue: [ ^ arrow beDown ].
	self column sortOrder = #descending ifTrue: [ ^ arrow beUp ].
	^ arrow beRight 
]

{ #category : #updating }
ToTableColumnHeaderElement >> updateColumn [
	(self childWithId: #label) text: column title.
	column sorterBlock ifNotNil: [
			| arrow |
			arrow := ToIconicArrowButton new.
			self startElement: arrow.
			self updateArrowOrientation: arrow.
			self startElement clickAction: [
				column nextSort.
				self updateArrowOrientation: arrow.
				self startElement fireEvent: (ToSortColumn column: column) ].
			self startInterspace: 10 ]
]
