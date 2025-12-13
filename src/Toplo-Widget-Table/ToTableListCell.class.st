Class {
	#name : #ToTableListCell,
	#superclass : #ToTableCell,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #skin }
ToTableListCell >> installRawStyle [

	super installRawStyle.
	self hMatchParent.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'table-cell-padding-H')
			 vertical: (self valueOfTokenNamed: #'table-cell-padding-V'))
]
