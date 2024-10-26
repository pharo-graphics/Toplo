Class {
	#name : #ToSingleSelectChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectedDataArray',
		'selectedIndexes'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedData [

	^ selectedDataArray ifNotEmpty: [ :s | s anyOne ] ifEmpty: [  ]
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedDataArray: aDataArray [

	selectedDataArray := aDataArray
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedIndex [

	^ selectedIndexes ifNotEmpty: [ :s | s anyOne ] ifEmpty: [ 0 ]
]

{ #category : #accessing }
ToSingleSelectChangedEvent >> selectedIndexes: anArray [

	selectedIndexes := anArray
]
