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
						withValue: BlFontWeightAttribute bold ] ]
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

	|  element |
	element := self headerColumnElements at: anIndex.
	element updateWidthWith: element column startDragWidth + aDistance
]

{ #category : #accessing }
ToTableHeaderElement >> dividerAt: anIndex startDragAt: aDistance [

	| headerColumnElements first |
	headerColumnElements := self selectChildrenWithId: #headerColumn.
	first := headerColumnElements at: anIndex.
	first column startDragWidth: first width
]

{ #category : #initialization }
ToTableHeaderElement >> freezeColumnsWidth [

	| headerColumnElements last |
	headerColumnElements := self selectChildrenWithId: #headerColumn.
	headerColumnElements allButLastDo: [ :e | e updateWidthWith: e width ].
	last := headerColumnElements last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #accessing }
ToTableHeaderElement >> headerColumnElements [

	^ self selectChildrenWithId: #headerColumn
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self vFitContent.
	self hMatchParent
]
