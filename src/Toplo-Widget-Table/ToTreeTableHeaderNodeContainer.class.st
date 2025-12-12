Class {
	#name : #ToTreeTableHeaderNodeContainer,
	#superclass : #ToTableHeaderNodeContainer,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTreeTableHeaderNodeContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #startInterspace)
				with: [ :header |
						| interspace arrowWidth |
						" the filler width = list node interspace + list node arrow width
						+ the padding of the header and of the inner table list element "
						interspace := header valueOfTokenNamed: #'node-interspace'.
						arrowWidth := header valueOfTokenNamed: #'iconic-arrow-breadth'.
						"nodeHPadding := header valueOfTokenNamed: #'list-node-padding-H'."
						interspace + arrowWidth "+ nodeHPadding "] ]
]
