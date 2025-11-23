Class {
	#name : #ToTableListCellContainer,
	#superclass : #ToTableCellContainer,
	#instVars : [
		'tableNodeHolder'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'instance creation' }
ToTableListCellContainer class >> holder: aTableNodeHolder column: aColumn [

	^ self basicNew
		  holder: aTableNodeHolder;
		  column: aColumn;
		  initialize;
		  yourself
]

{ #category : #initialization }
ToTableListCellContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :cell |
					cell padding: (BlInsets
							 horizontal: (cell valueOfTokenNamed: #'table-cell-padding-H')
							 vertical: (cell valueOfTokenNamed: #'table-cell-padding-V')) ] ]
]

{ #category : #accessing }
ToTableListCellContainer >> holder: aTableNodeHolder [

	tableNodeHolder := aTableNodeHolder 
]

{ #category : #'t - triplet container - instance creation' }
ToTableListCellContainer >> newMiddleContainer [ 

	^ column cellFactory cull: tableNodeHolder
]
