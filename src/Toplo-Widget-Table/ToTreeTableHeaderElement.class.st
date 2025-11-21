Class {
	#name : #ToTreeTableHeaderElement,
	#superclass : #ToTableHeaderElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTreeTableHeaderElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: #treeTableHeaderFiller asIdSelector style: [
			aTheme when: ToInstallSkinEvent do: [ :filler |
					| interspace arrowWidth nodeHPadding |
					" the filler width = list node interspace + list node arrow width
					+ the padding of the header and of the inner table list element "
					interspace := filler valueOfTokenNamed: #'node-interspace'.
					arrowWidth := filler valueOfTokenNamed: #'iconic-arrow-breadth'.
					nodeHPadding := filler valueOfTokenNamed: #'list-node-padding-H'.
					filler width: interspace + arrowWidth + nodeHPadding ] ]
]

{ #category : #initialization }
ToTreeTableHeaderElement >> initialize [

	| headerFiller |
	super initialize.
	headerFiller := ToElement new
		                id: #treeTableHeaderFiller;
		                yourself.
	self addChild: headerFiller at: 1
]
