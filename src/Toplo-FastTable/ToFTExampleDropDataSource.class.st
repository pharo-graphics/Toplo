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
	self elements: (rowIndex = 0
		ifTrue: [ self elements, aCollection ]
		ifFalse: [ (self elements first: rowIndex), aCollection, (self elements allButFirst: rowIndex) ])
]

{ #category : #initialization }
ToFTExampleDropDataSource >> initialize [
	super initialize.
	self elements: #()
]

{ #category : #'drag and drop' }
ToFTExampleDropDataSource >> wantsDropElements: aCollection type: type index: rowIndex [
	^ aCollection allSatisfy: #isClass
]
