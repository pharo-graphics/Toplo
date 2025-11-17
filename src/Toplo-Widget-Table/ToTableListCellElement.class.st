Class {
	#name : #ToTableListCellElement,
	#superclass : #ToTableCellElement,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableListCellElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :cell |
					cell padding: (BlInsets
							 horizontal: (cell valueOfTokenNamed: #'table-cell-padding-H')
							 vertical: (cell valueOfTokenNamed: #'table-cell-padding-V')) ] ]
]
