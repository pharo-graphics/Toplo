Class {
	#name : #ToSingleSelectNodeContainerElement,
	#superclass : #ToSingleSelectionElementBarNodeContainerElement,
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

	super refresh.
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
