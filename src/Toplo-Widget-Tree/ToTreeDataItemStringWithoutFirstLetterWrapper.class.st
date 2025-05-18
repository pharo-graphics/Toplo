Class {
	#name : #ToTreeDataItemStringWithoutFirstLetterWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-examples'
}

{ #category : #accessing }
ToTreeDataItemStringWithoutFirstLetterWrapper >> computedChildren [

	^ dataItem size = 1
		  ifFalse: [
			  OrderedCollection new
				  add: (dataItem withoutPrefix: dataItem first asString);
				  yourself ]
		  ifTrue: [ OrderedCollection empty ]
]
