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
		withValue: BlFontWeightAttribute bold.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'table-cell-padding-H')
			 vertical: (self valueOfTokenNamed: #'table-cell-padding-V'))
]
