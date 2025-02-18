Class {
	#name : #ToTreeDataItemStringWithoutFirstLetterWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'as yet unclassified' }
ToTreeDataItemStringWithoutFirstLetterWrapper >> determineChildren [

	^ dataItem size = 1
		  ifFalse: [
			  OrderedCollection new
				  add: (dataItem withoutPrefix: dataItem first asString);
				  yourself ]
		  ifTrue: [ OrderedCollection empty ]
]
