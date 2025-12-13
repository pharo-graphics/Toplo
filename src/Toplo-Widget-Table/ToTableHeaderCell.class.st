Class {
	#name : #ToTableHeaderCell,
	#superclass : #ToTableCell,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #skin }
ToTableHeaderCell >> installRawStyle [

	super installRawStyle.
	self
		addTokenNamed: #'font-weight-attribute'
		withValue: BlFontWeightAttribute bold
]
