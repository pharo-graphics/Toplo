Class {
	#name : #ToTreeTableElement,
	#superclass : #ToTableElement,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTreeTableElement >> newHeaderElement [

	^ ToTreeTableHeaderNodeContainer new
]

{ #category : #initialization }
ToTreeTableElement >> newListElement [

	^ ToTreeTableListElement new
]
