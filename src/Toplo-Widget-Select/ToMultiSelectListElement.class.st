Class {
	#name : #ToMultiSelectListElement,
	#superclass : #ToSelectListElement,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToMultiSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection and the select list according to the sieve selection model"

	super applyDataSourceSieveCommand: aDataSourceCommand.
	selectElement checkHideSelectionFromListElement.
	selectElement checkMaxSelectedCount
]

{ #category : #initialization }
ToMultiSelectListElement >> defaultEventHandler [

	^ ToMultiSelectListElementEventHandler new
]

{ #category : #initialization }
ToMultiSelectListElement >> defaultNodeManagerClass [ 

	^ ToMultiSelectListNodeManager 
]

{ #category : #'accessing - selection' }
ToMultiSelectListElement >> hideSelection [

	self sieve withLocalAndOriginalIndexDo: [ :d :localIndex :originalIndex |
		(self selectionModel containsIndex: localIndex)
			ifTrue: [ self selectionModel hideIndex: localIndex ]
			ifFalse: [ self selectionModel unhideIndex: localIndex ] ].
	self notifyDataSourceChanged
]

{ #category : #initialization }
ToMultiSelectListElement >> listNodeClass [

	^ ToMultiSelectListNode
]
