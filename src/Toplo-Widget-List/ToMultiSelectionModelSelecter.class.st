Class {
	#name : #ToMultiSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectAll [

	self addCommand: (ToWholeSelectionCommand new
			 operator: self operator;
			 operation: ToAddSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self addCommand: (ToIntervalSelectionCommand new
			 operator: self operator;
			 from: aStartIndex to: anEndIndex;
			 operation: ToAddSelectionOperation new)
]

{ #category : #operations }
ToMultiSelectionModelSelecter >> selectIndexes: anArray [

	self addCommand: (ToIndexesSelectionCommand new
			 operator: self operator;
			 indexes: anArray;
			 operation: ToAddSelectionOperation new)
]
