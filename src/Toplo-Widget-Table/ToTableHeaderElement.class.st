"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme when: ToInstallSkinEvent do: [ :header |
					header
						addTokenNamed: #'font-weight-attribute'
						withValue: BlFontWeightAttribute bold ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :header |
						BlInsets
							horizontal: (header valueOfTokenNamed: #'list-padding-H')
							vertical: (header valueOfTokenNamed: #'list-padding-V') ] ]
]

{ #category : #initialization }
ToTableHeaderElement >> buildHeaderLabelFor: column [

	^ ToTableColumnHeaderElement column: column 
]

{ #category : #accessing }
ToTableHeaderElement >> columns: aTableColumnArray [

	self removeChildren.
	aTableColumnArray do: [ :column |
		self addChild: (self buildHeaderLabelFor: column)  ]
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #accessing }
ToTableHeaderElement >> dividerAt: anIndex movedBy: aDistance from: aStartLocation [

	| headerColumnElements first second |
	headerColumnElements := self selectChildrenWithId: #headerColumn.
	first := headerColumnElements at: anIndex.
	second := headerColumnElements at: anIndex + 1.
	first width: aStartLocation + aDistance.
	first column width: aStartLocation + aDistance.
	"second width: aStartLocation - aDistance.
	second column width: aStartLocation - aDistance"
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self vFitContent.
	self hMatchParent
]
