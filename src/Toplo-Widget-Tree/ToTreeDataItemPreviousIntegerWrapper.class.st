Class {
	#name : #ToTreeDataItemPreviousIntegerWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemPreviousIntegerWrapper >> determineChildren [

	^ dataItem = 1
		  ifTrue: [ {} ]
		  ifFalse: [ {dataItem - 1} ]
]
