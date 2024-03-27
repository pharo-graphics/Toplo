Class {
	#name : #ToAbstractListElementSelecter,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #testing }
ToAbstractListElementSelecter >> containsIndex: anIndex [

	^ self subclassResponsibility 
]

{ #category : #copying }
ToAbstractListElementSelecter >> copySelectionFrom: aSourceSelectionModel [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElementSelecter >> currentIndex [

	^ self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> deselectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self subclassResponsibility
]

{ #category : #operations }
ToAbstractListElementSelecter >> deselectIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #private }
ToAbstractListElementSelecter >> nextDeselectedIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractListElementSelecter >> nextSelectableIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractListElementSelecter >> previousDeselectedIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractListElementSelecter >> previousSelectableIndex [

	^ self subclassResponsibility
]

{ #category : #operations }
ToAbstractListElementSelecter >> scrollToIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectOnlyIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractListElementSelecter >> selectOnlyIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListElementSelecter >> selectedIndexes [ 

	^ self subclassResponsibility 
]
