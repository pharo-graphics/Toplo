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
	" Hiding is implemented with the list hidden selection model.
	The node hiding works as follow:
	- an hidden node index is selected (added) in the hidden selection model
	- then all nodeContainers are rebuilt (because of the #notifyDataSourceChange send)
	- see ToNodeHolder>>#initializeNode, to have a look on how the hiiden is visually implemented.
	by default, the height of the node container is set to zero.
	"

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
