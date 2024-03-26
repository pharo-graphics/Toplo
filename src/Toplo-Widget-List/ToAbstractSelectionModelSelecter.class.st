Class {
	#name : #ToAbstractSelectionModelSelecter,
	#superclass : #Object,
	#instVars : [
		'operator',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToAbstractSelectionModelSelecter class >> selectionModel: aSelectionModel operator: anOperator [

	^ self new
		  selectionModel: aSelectionModel;
		  operator: anOperator;
		  yourself
]

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

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> operateSilently [

	^ false
]

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> operator: anOperator [

	operator := anOperator
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

{ #category : #accessing }
ToAbstractSelectionModelSelecter >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
