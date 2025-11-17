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

{ #category : #accessing }
ToTableHeaderElement >> cells [

	^ self selectChildrenWithId: #headerCell
]

{ #category : #accessing }
ToTableHeaderElement >> columns: aTableColumnArray [

	self removeChildren.
	aTableColumnArray do: [ :column | | cell |
		cell := self newCell.
		self addChild: cell.
		cell column: column.
		cell initializeFromColumn ]
]

{ #category : #initialization }
ToTableHeaderElement >> defaultLayout [ 

	" don't use vertical or horizontal to allow vertical centering of children "
	^ BlLinearLayout new
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cell |
	cell := self cells at: aDivider cellIndex.
	cell updateWidthWith: cell column startDragWidth + aDistance
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider startDragAt: aDistance [

	|  cell |
	cell := self cells at: aDivider cellIndex.
	cell column startDragWidth: cell width
]

{ #category : #initialization }
ToTableHeaderElement >> freezeCellsWidth [

	| last |
	self cells allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self cells last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self vFitContent.
	self hMatchParent
]

{ #category : #initialization }
ToTableHeaderElement >> newCell [

	^ ToTableHeaderCellElement new
]
