Class {
	#name : #ToTreeTableElement,
	#superclass : #ToTableElement,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #'expanding-collapsing' }
ToTreeTableElement >> expandRoots [
	self list expandRoots
]

{ #category : #initialization }
ToTreeTableElement >> newHeaderElement [

	^ ToTreeTableHeaderElement parentTable: self
]

{ #category : #initialization }
ToTreeTableElement >> newListElement [

	^ ToTreeTableListElement parentTable: self
]
