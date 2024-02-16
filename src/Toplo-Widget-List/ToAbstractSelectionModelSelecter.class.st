Class {
	#name : #ToAbstractSelectionModelSelecter,
	#superclass : #Object,
	#instVars : [
		'operateSilently'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> beSilentWhile: aBlock [

	| prev |
	prev := operateSilently.
	operateSilently := true.
	aBlock ensure: [ operateSilently := prev ]
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
ToAbstractSelectionModelSelecter >> deselectAllIndexes: anArray [

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

	^ operateSilently ifNil: [ operateSilently := false ]
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> previousDeselectedIndex [

	^ self subclassResponsibility 
]

{ #category : #private }
ToAbstractSelectionModelSelecter >> previousSelectableIndex [

	^ self subclassResponsibility
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> scrollToCurrentIndex [

	self subclassResponsibility
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> scrollToIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> scrollToNextIndex [

	self subclassResponsibility
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> scrollToPreviousIndex [

	self subclassResponsibility
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
ToAbstractSelectionModelSelecter >> selectIndex: anIndex [

	self subclassResponsibility 
]

{ #category : #operations }
ToAbstractSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self subclassResponsibility 
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectNextIndex [

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
ToAbstractSelectionModelSelecter >> selectPreviousIndex [

	self subclassResponsibility
]

{ #category : #'shortcuts operations' }
ToAbstractSelectionModelSelecter >> selectToIndex: index [

	self subclassResponsibility 
]
