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

	^ self new
		  holder: aTableNodeHolder column: aColumn;
		  yourself
]

{ #category : #initialization }
ToTableListCellContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :cont |
						BlInsets
							horizontal: (cont valueOfTokenNamed: #'table-cell-padding-H')
							vertical: (cont valueOfTokenNamed: #'table-cell-padding-V') ] ]
]

{ #category : #accessing }
ToTableListCellContainer >> holder: aTableNodeHolder [

	tableNodeHolder := aTableNodeHolder 
]

{ #category : #accessing }
ToTableListCellContainer >> holder: aTableNodeHolder column: aColumn [

	self holder: aTableNodeHolder.
	self column: aColumn
]

{ #category : #'t - triplet container - instance creation' }
ToTableListCellContainer >> newMiddleContainer [ 

	^ column cellFactory cull: tableNodeHolder
]
