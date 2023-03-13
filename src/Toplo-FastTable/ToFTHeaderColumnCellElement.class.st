"
I represent a column header cell morph, i handle mouse click and double to trigger the needed functionalities.
"
Class {
	#name : #ToFTHeaderColumnCellElement,
	#superclass : #ToFTCellElement,
	#instVars : [
		'column'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #accessing }
ToFTHeaderColumnCellElement >> column [
	^ column
]

{ #category : #accessing }
ToFTHeaderColumnCellElement >> column: aColumn [
	column  := aColumn
]

{ #category : #'event handling' }
ToFTHeaderColumnCellElement >> handlesMouseDown: event [
	^ true
]

{ #category : #'event handling' }
ToFTHeaderColumnCellElement >> handlesMouseOver: event [
	^ false
]

{ #category : #'event handling' }
ToFTHeaderColumnCellElement >> mouseDown: event [
	self column sortDataSource: self table dataSource
]
