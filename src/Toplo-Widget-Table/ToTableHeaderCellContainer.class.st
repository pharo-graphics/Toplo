Class {
	#name : #ToTableHeaderCellContainer,
	#superclass : #ToTableCellContainer,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'instance creation' }
ToTableHeaderCellContainer class >> column: aColumn [

	^ self new
		  initializeWithColumn: aColumn;
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

{ #category : #updating }
ToTableHeaderCellContainer >> initializeFromColumnInTableElement: aTableElement [

	column buildHeaderCellInContainer: self inTableElement: aTableElement.
	column sorterBlock ifNotNil: [
			| sorterContainer |
			sorterContainer := self newSorterContainer.
			self ensureEndContainer.
			self endContainer addChild: sorterContainer.
			column sorterContainerBuilder
				cull: sorterContainer
				cull: column
				cull: aTableElement ]
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
