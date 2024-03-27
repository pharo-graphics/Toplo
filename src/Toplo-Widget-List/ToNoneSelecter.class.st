Class {
	#name : #ToNoneSelecter,
	#superclass : #ToAbstractListElementSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #testing }
ToNoneSelecter >> containsIndex: anIndex [

	^ false
]

{ #category : #copying }
ToNoneSelecter >> copySelectionFrom: aSourceSelectionModel [


]

{ #category : #accessing }
ToNoneSelecter >> currentIndex [

	^ 0
]

{ #category : #operations }
ToNoneSelecter >> deselectAll [

]

{ #category : #operations }
ToNoneSelecter >> deselectIndex: anIndex [
]

{ #category : #operations }
ToNoneSelecter >> deselectIndex: aStartIndex to: anEndIndex [

]

{ #category : #operations }
ToNoneSelecter >> deselectIndexes: anArray [

]

{ #category : #private }
ToNoneSelecter >> nextDeselectedIndex [

	^ 0
]

{ #category : #private }
ToNoneSelecter >> nextSelectableIndex [

	^ 0
]

{ #category : #private }
ToNoneSelecter >> previousDeselectedIndex [

	^ 0
]

{ #category : #private }
ToNoneSelecter >> previousSelectableIndex [

	^ 0
]

{ #category : #operations }
ToNoneSelecter >> scrollToIndex: anIndex [


]

{ #category : #operations }
ToNoneSelecter >> selectAll [
]

{ #category : #operations }
ToNoneSelecter >> selectIndex: anIndex [
]

{ #category : #operations }
ToNoneSelecter >> selectIndex: aStartIndex to: anEndIndex [
]

{ #category : #operations }
ToNoneSelecter >> selectIndexes: anArray [
]

{ #category : #operations }
ToNoneSelecter >> selectOnlyIndex: anIndex [
]

{ #category : #operations }
ToNoneSelecter >> selectOnlyIndexes: anArray [
]

{ #category : #accessing }
ToNoneSelecter >> selectedIndexes [

	^ #(  )
]
