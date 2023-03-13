"
I'm a simple example of fast table who will accept drops of classes.

ToFTExamples exampleDragAndDrop1.

"
Class {
	#name : #ToFTExampleDropDataSource,
	#superclass : #ToFTSimpleDataSource,
	#category : #'Toplo-FastTable-Examples'
}

{ #category : #'drag and drop' }
ToFTExampleDropDataSource >> dropElements: aCollection index: rowIndex [
	self data: (rowIndex = 0
		ifTrue: [ self data, aCollection ]
		ifFalse: [ (self data first: rowIndex), aCollection, (self data allButFirst: rowIndex) ])
]

{ #category : #initialization }
ToFTExampleDropDataSource >> initialize [
	super initialize.
	self data: #()
]

{ #category : #'drag and drop' }
ToFTExampleDropDataSource >> wantsDropElements: aCollection type: type index: rowIndex [
	^ aCollection allSatisfy: #isClass
]
