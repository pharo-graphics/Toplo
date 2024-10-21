Class {
	#name : #ToMultiSelectListElement,
	#superclass : #ToSelectListElement,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #'private - commands' }
ToMultiSelectListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection according to the sieve selection model"

	super applyDataSourceSieveCommand: aDataSourceCommand.
	selectElement checkHideSelectionFromListElement.
	selectElement checkMaxSelectedCount
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
ToMultiSelectListElement >> initialize [

	super initialize.
	self primarySelectionMode makeDisabledUnselectable: true.
	self primarySelectionMode selectOnMouseDown: true.
	self primarySelectionMode requestFocusOnMouseDown: false.
	self nodeHolderClass: ToMultiSelectListNodeHolder.
	self nodeFactory: [ :holder | ToMultiSelectListNode new ]
]
