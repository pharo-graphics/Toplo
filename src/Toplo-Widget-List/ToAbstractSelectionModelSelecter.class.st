Class {
	#name : #ToAbstractSelectionModelSelecter,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #copying }
ToAbstractSelectionModelSelecter >> copySelectionFrom: aSourceSelectionModel [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> currentIndex [ 

	^ self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectIndex: aStartIndex to: anEndIndex [

	self subclassResponsibility
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> nextDeselectedIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> nextSelectableIndex [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToAbstractSelectionModelSelecter >> onInstalledIn: anEventTarget [
]

{ #category : #'api - hooks' }
ToAbstractSelectionModelSelecter >> onUninstalledIn: anEventTarget [
]

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> operateSilently [

	^ false
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> previousDeselectedIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> previousSelectableIndex [

	^ self subclassResponsibility
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> scrollToIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> selectedIndexes [

	^ self subclassResponsibility 
]
