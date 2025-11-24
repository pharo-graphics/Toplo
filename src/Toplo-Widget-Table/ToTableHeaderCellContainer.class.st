Class {
	#name : #ToTableHeaderCellContainer,
	#superclass : #ToTableCellContainer,
	#instVars : [
		'state'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'instance creation' }
ToTableHeaderCellContainer class >> column: aColumn [

	^ self basicNew
		  column: aColumn;
		  initialize;
		  yourself
]

{ #category : #initialization }
ToTableHeaderCellContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				do: [ :cont | "cont background: Color red."
						cont
							addTokenNamed: #'font-weight-attribute'
							withValue: BlFontWeightAttribute bold ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :cont |
						BlInsets
							horizontal: (cont valueOfTokenNamed: #'table-cell-padding-H')
							vertical:
							(cont valueOfTokenNamed: #'table-header-cell-padding-V') ] ]
]

{ #category : #accessing }
ToTableHeaderCellContainer >> column: aTableColumn [

	super column: aTableColumn.
	self initializeState
]

{ #category : #initialization }
ToTableHeaderCellContainer >> initialize [

	super initialize.
	self id: #headerCellContainer
]

{ #category : #updating }
ToTableHeaderCellContainer >> initializeFromColumnInTableElement: aTableElement [

	column buildHeaderCellInContainer: self inTableElement: aTableElement.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ].
	column sorterBlock ifNotNil: [
			| sorterContainer |
			sorterContainer := self newSorterContainer.
			self endContainer addChild: sorterContainer.
			column sorterContainerBuilder
				cull: sorterContainer
				cull: column
				cull: aTableElement ]
]

{ #category : #initialization }
ToTableHeaderCellContainer >> initializeState [

	self state initializeFromColumn: column
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderCellContainer >> newMiddleContainer [ 

	^ column headerCellFactory value
]

{ #category : #updating }
ToTableHeaderCellContainer >> newSorterContainer [

	| sorterContainer |
	sorterContainer := ToElement new
		                   id: #sorterContainer;
		                   yourself.
	sorterContainer layout: BlLinearLayout horizontal.
	sorterContainer fitContent.
	sorterContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	^ sorterContainer
]

{ #category : #accessing }
ToTableHeaderCellContainer >> state [

	^ state ifNil: [ state := self newColumnState ]
]

{ #category : #accessing }
ToTableHeaderCellContainer >> updateWidthWith: aNumber [

	state width: aNumber.
	super updateWidthWith: aNumber.

]
