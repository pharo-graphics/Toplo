Class {
	#name : #ToAbstractSelectionModelSelecter,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> currentIndex [ 

	^ self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectAllIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> deselectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToAbstractSelectionModelSelecter >> onInstalledIn: anEventTarget [
]

{ #category : #'api - hooks' }
ToAbstractSelectionModelSelecter >> onUninstalledIn: anEventTarget [
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectAll [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectAllIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectAndScrollToIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectAndScrollToNext [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectAndScrollToNextDeselected [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectAndScrollToPrevious [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectAndScrollToPreviousDeselected [

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
ToAbstractSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectToIndex: index [

	self subclassResponsibility 
]
