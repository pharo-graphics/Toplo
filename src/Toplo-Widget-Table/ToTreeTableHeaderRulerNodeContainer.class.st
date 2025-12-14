Class {
	#name : #ToTreeTableHeaderRulerNodeContainer,
	#superclass : #ToTableHeaderRulerNodeContainer,
	#category : #'Toplo-Widget-Table-HeaderRuler'
}

{ #category : #skin }
ToTreeTableHeaderRulerNodeContainer >> installRawStyle [

	| interspace arrowWidth |
	super installRawStyle.
	" the filler width = list node interspace + list node arrow width "
	interspace := self valueOfTokenNamed: #'node-interspace'.
	arrowWidth := self valueOfTokenNamed: #'iconic-arrow-breadth'.
	self startInterspace: interspace + arrowWidth
]
