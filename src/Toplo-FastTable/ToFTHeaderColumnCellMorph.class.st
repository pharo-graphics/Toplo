"
I represent a column header cell morph, i handle mouse click and double to trigger the needed functionalities.
"
Class {
	#name : #ToFTHeaderColumnCellMorph,
	#superclass : #ToFTCellMorph,
	#instVars : [
		'column'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #accessing }
ToFTHeaderColumnCellMorph >> column [
	^ column
]

{ #category : #accessing }
ToFTHeaderColumnCellMorph >> column: aColumn [
	column  := aColumn
]

{ #category : #'event handling' }
ToFTHeaderColumnCellMorph >> handlesMouseDown: event [
	^ true
]

{ #category : #'event handling' }
ToFTHeaderColumnCellMorph >> handlesMouseOver: event [
	^ false
]

{ #category : #'event handling' }
ToFTHeaderColumnCellMorph >> mouseDown: event [
	self column sortDataSource: self table dataSource
]
