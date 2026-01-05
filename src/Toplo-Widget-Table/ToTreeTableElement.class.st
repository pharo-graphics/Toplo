Class {
	#name : #ToTreeTableElement,
	#superclass : #ToTableElement,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTreeTableElement >> newHeaderElement [

	^ ToTreeTableHeaderElement parentTable: self
]

{ #category : #initialization }
ToTreeTableElement >> newListElement [

	^ ToTreeTableListElement parentTable: self
]
