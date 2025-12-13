Class {
	#name : #ToTreeTableHeaderElement,
	#superclass : #ToTableHeaderElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTreeTableHeaderElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	"<toploThemeInstallerFor: #ToRawTheme>"
	aTheme select: (self asTypeSelector exact: true) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :header |
						| interspace arrowWidth nodeHPadding |
						" the filler width = list node interspace + list node arrow width
						+ the padding of the header and of the inner table list element "
						interspace := header valueOfTokenNamed: #'node-interspace'.
						arrowWidth := header valueOfTokenNamed: #'iconic-arrow-breadth'.
						nodeHPadding := header valueOfTokenNamed: #'list-padding-H'.
						BlInsets empty "left: interspace + arrowWidth + nodeHPadding" ] ]
]

{ #category : #accessing }
ToTreeTableHeaderElement >> newHeaderColumnsRuler [

	^ ToTreeTableHeaderRulerNodeContainer new
]

{ #category : #accessing }
ToTreeTableHeaderElement >> newHeaderNodeContainer [

	^ ToTreeTableHeaderNodeContainer new
]
