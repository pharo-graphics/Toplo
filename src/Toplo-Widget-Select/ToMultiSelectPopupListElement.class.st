Class {
	#name : #ToMultiSelectPopupListElement,
	#superclass : #ToSelectPopupListElement,
	#category : #'Toplo-Widget-Select-PopupList'
}

{ #category : #'private - commands' }
ToMultiSelectPopupListElement >> applyDataSourceSieveCommand: aDataSourceCommand [
	" update the selection and the select list according to the sieve selection model"

	super applyDataSourceSieveCommand: aDataSourceCommand.
	selectElement checkHideSelectionFromListElement.
	selectElement checkMaxSelectedCountInPopupList
]

{ #category : #initialization }
ToMultiSelectPopupListElement >> defaultEventHandler [

	^ ToMultiSelectPopupListElementEventHandler new
]

{ #category : #initialization }
ToMultiSelectPopupListElement >> defaultNodeManager [

	^ self defaultNodeManagerClass new
		  nodeHolderFactory: [ ToMultiSelectPopupListNodeHolder new ];
		  yourself
]

{ #category : #'accessing - selection' }
ToMultiSelectPopupListElement >> hideSelection [
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
ToMultiSelectPopupListElement >> listNodeClass [

	^ ToMultiSelectPopupListNode
]
