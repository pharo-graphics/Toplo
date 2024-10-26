Class {
	#name : #ToSelectChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectedIndexes',
		'selectedDataItems'
	],
	#category : #'Toplo-Widget-Select-Single'
}

{ #category : #accessing }
ToSelectChangedEvent >> selectedData [

	^ self selectedDataItems ifNotEmpty: [ :s | s anyOne ] ifEmpty: [  ]
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedData: aDataItem [

	self selectedDataItems:
		(aDataItem ifNil: [ #(  ) ] ifNotNil: [ { aDataItem } ])
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedDataItems [

	^ selectedDataItems
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedDataItems: aDataArray [

	selectedDataItems := aDataArray
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedIndex [

	^ self selectedIndexes ifNotEmpty: [ :s | s anyOne ] ifEmpty: [ 0 ]
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedIndex: aSelectedIndex [
	"aSelectedIndex can be zero in case none is selected "

	self selectedIndexes: { aSelectedIndex }
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedIndexes [

	^ selectedIndexes
]

{ #category : #accessing }
ToSelectChangedEvent >> selectedIndexes: anArray [

	selectedIndexes := anArray
]
