Class {
	#name : #ToTreeTableHeaderRulerNodeContainer,
	#superclass : #ToTableHeaderRulerNodeContainer,
	#category : #'Toplo-Widget-Table-HeaderRuler'
}

{ #category : #skin }
ToTreeTableHeaderRulerNodeContainer >> installRawStyle [

	| interspace arrowWidth nodeHPadding gap |
	super installRawStyle.
	" the filler width = list node interspace + list node arrow width
						+ the padding of the header and of the inner table list element "
	interspace := self valueOfTokenNamed: #'node-interspace'.
	arrowWidth := self valueOfTokenNamed: #'iconic-arrow-breadth'.
	nodeHPadding := self valueOfTokenNamed: #'list-padding-H'.
	gap := interspace + arrowWidth + nodeHPadding.
	self padding: (BlInsets left: gap right: nodeHPadding)
]
