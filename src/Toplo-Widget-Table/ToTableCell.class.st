Class {
	#name : #ToTableCell,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #initialization }
ToTableCell >> initialize [ 

	super initialize.
	self hMatchParent.
	self vFitContent
]
