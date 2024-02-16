Class {
	#name : #ToNoneSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToNoneSelectionModelSelecter >> currentIndex [

	^ 0
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> deselectAll [

]

{ #category : #operations }
ToNoneSelectionModelSelecter >> deselectAllIndexes: anArray [

]

{ #category : #operations }
ToNoneSelectionModelSelecter >> deselectIndex: anIndex [
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

]

{ #category : #private }
ToNoneSelectionModelSelecter >> nextDeselectedIndex [

	^ 0
]

{ #category : #private }
ToNoneSelectionModelSelecter >> nextSelectableIndex [

	^ 0
]

{ #category : #private }
ToNoneSelectionModelSelecter >> previousDeselectedIndex [

	^ 0
]

{ #category : #private }
ToNoneSelectionModelSelecter >> previousSelectableIndex [

	^ 0
]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> scrollToCurrentIndex [


]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> scrollToIndex: anIndex [


]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> scrollToNextIndex [


]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> scrollToPreviousIndex [

]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectAll [
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectAllIndexes: anArray [
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectIndex: anIndex [
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [
]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> selectNextIndex [


]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectOnlyIndex: anIndex [
]

{ #category : #operations }
ToNoneSelectionModelSelecter >> selectOnlyIndexes: anArray [
]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> selectPreviousIndex [
]

{ #category : #'shortcuts operations' }
ToNoneSelectionModelSelecter >> selectToIndex: index [
]
