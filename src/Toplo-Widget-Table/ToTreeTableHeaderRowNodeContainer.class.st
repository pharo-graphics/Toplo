Class {
	#name : #ToTreeTableHeaderRowNodeContainer,
	#superclass : #ToTableHeaderRowNodeContainer,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #skin }
ToTreeTableHeaderRowNodeContainer >> installRawStyle [

	| interspace arrowWidth |
	super installRawStyle.
	" the filler width = list node interspace + list node arrow width "
	interspace := self valueOfTokenNamed: #'node-interspace'.
	arrowWidth := self valueOfTokenNamed: #'iconic-arrow-breadth'.
	self startInterspace: interspace + arrowWidth
]
