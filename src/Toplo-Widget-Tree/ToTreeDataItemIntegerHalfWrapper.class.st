Class {
	#name : #ToTreeDataItemIntegerHalfWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemIntegerHalfWrapper >> determineChildren [

	children := dataItem // 2 = 0
		  ifTrue: [ OrderedCollection empty ]
		  ifFalse: [ (dataItem // 2) asOrderedCollection ]
]
