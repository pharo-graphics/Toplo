Class {
	#name : #ToListDataSourceItemsChangeEvent,
	#superclass : #ToListElementEvent,
	#instVars : [
		'itemCount',
		'position'
	],
	#category : #'Toplo-Widget-List-Selection-Events'
}

{ #category : #accessing }
ToListDataSourceItemsChangeEvent >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToListDataSourceItemsChangeEvent >> itemCount: anInteger [

	itemCount := anInteger
]

{ #category : #accessing }
ToListDataSourceItemsChangeEvent >> position [

	^ position
]

{ #category : #accessing }
ToListDataSourceItemsChangeEvent >> position: aDataSourcePosition [

	position := aDataSourcePosition
]
