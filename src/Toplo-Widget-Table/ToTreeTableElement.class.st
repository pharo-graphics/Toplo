Class {
	#name : #ToTreeTableElement,
	#superclass : #ToTableElement,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTreeTableElement >> newListElement [

	^ ToTreeTableListElement new
		  id: #list;
		  yourself
]
