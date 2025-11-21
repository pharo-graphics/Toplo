Class {
	#name : #ToTableColumnState,
	#superclass : #Object,
	#instVars : [
		'width',
		'startDragWidth'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTableColumnState >> initializeFromColumn: aTableColumn [

	width := aTableColumn width
]

{ #category : #accessing }
ToTableColumnState >> startDragWidth [

	^ startDragWidth
]

{ #category : #accessing }
ToTableColumnState >> startDragWidth: aNumber [

	startDragWidth := aNumber
]

{ #category : #accessing }
ToTableColumnState >> width [

	^ width
]

{ #category : #accessing }
ToTableColumnState >> width: aNumber [

	width := aNumber
]
