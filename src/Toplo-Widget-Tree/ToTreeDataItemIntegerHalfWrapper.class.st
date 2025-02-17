Class {
	#name : #ToTreeDataItemIntegerHalfWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemIntegerHalfWrapper >> determineChildren [

	^ dataItem // 2 = 0
		  ifTrue: [ OrderedCollection empty ]
		  ifFalse: [ (dataItem // 2) asOrderedCollection ]
]
