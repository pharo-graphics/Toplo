Class {
	#name : #ToSingleSelectionModelSelecter,
	#superclass : #ToSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToSingleSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> deselectIndexes: anArray [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectAll [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: anIndex [

	self addCommand: (ToCompositeCommand new commands: {
				 (ToWholeSelectionCommand new
					  silent: true;
					  operation: ToRemoveSelectionOperation new).
				 (ToIntervalSelectionCommand new
					  from: anIndex to: anIndex;
					  operation: ToAddSelectionOperation new) }).
	self changeCurrentIndexWith: anIndex
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectIndexes: anArray [

	ToInvalidCommand signal
]

{ #category : #operations }
ToSingleSelectionModelSelecter >> selectOnlyIndexes: anArray [

	ToInvalidCommand signal
]
