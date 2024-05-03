Class {
	#name : #ToSingleSelectNodeContainerElement,
	#superclass : #ToSingleSelectionElementBarContainerElement,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #initialization }
ToSingleSelectNodeContainerElement >> defaultNodeClass [ 

	^  ToSingleSelectNode
]

{ #category : #accessing }
ToSingleSelectNodeContainerElement >> filterString [ 

	^ self textInputElement filterString
]

{ #category : #accessing }
ToSingleSelectNodeContainerElement >> inputTextField [

	^ self textInputElement inputTextField
]

{ #category : #accessing }
ToSingleSelectNodeContainerElement >> refresh [

	| nodeHolder idx selectedData |
	nodeHolder := node holder.
	elementBar selectionModel isEmpty
		ifTrue: [
			idx := 0.
			selectedData := nil ]
		ifFalse: [
			idx := elementBar selectionModel firstIndex.
			selectedData := idx <= elementBar dataAccessor size
				                ifTrue: [ elementBar dataAccessor at: idx ]
				                ifFalse: [  ] ].
	nodeHolder
		position: idx;
		dataItem: selectedData.
	self refreshInputTextElementWithSelectedData
]

{ #category : #accessing }
ToSingleSelectNodeContainerElement >> refreshInputTextElementWithSelectedData [

	self inputTextField text: ''.
	self selectedDataTextField text:
		(node holder dataItem ifNil: [ '' ] ifNotNil: [ :d | d asString ])
]

{ #category : #accessing }
ToSingleSelectNodeContainerElement >> textInputElement [

	^ node textInputElement
]
