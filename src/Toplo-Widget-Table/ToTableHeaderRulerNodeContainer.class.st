"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderRulerNodeContainer,
	#superclass : #ToTripletContainer,
	#instVars : [
		'parentTable',
		'checkbox'
	],
	#category : #'Toplo-Widget-Table-HeaderRuler'
}

{ #category : #initialization }
ToTableHeaderRulerNodeContainer class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :e |
						BlInsets empty
							"horizontal: (e valueOfTokenNamed: #'list-padding-H')
							vertical: (e valueOfTokenNamed: #'list-padding-V') "] ]
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> addCheckbox [

	checkbox ifNotNil: [ ^ self ].
	checkbox := parentTable newHeaderCheckbox.
	checkbox constraintsDo: [ :c | c linear vertical alignCenter ].
	self ensureStartContainer.
	self startContainer addChild: checkbox
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> cleanUp [ 

	self removeCheckbox.
	self middleContainer removeChildren
]

{ #category : #accessing }
ToTableHeaderRulerNodeContainer >> columnStateAt: anIndex [

	^ (self rulerCells at: anIndex) state
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #'divider dragging' }
ToTableHeaderRulerNodeContainer >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cont minWidth column |
	cont := self rulerCells at: aDivider cellIndex.
	column := cont column.
	minWidth := column minWidth.
	cont updateWidthWith: ((cont state startDragWidth + aDistance) max: minWidth)
]

{ #category : #'divider dragging' }
ToTableHeaderRulerNodeContainer >> divider: aDivider startDragAt: aDistance [

	|  cont |
	cont := self rulerCells at: aDivider cellIndex.
	cont state startDragWidth: cont width
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> initialize [

	super initialize.
	self createMiddleContainer.
	self height: 0.
	self hMatchParent
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> initializeDividers [

	| containers index |
	parentTable removeDividers.
	containers := self rulerCells.
	index := 0.
	containers overlappingPairsDo: [ :first :second |
			| col |
			index := index + 1.
			col := first column.
			col resizable ifTrue: [
				parentTable addDivider: parentTable newDivider atIndex: index ] ].
	parentTable requestDividersUpdate
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> initializeWithColumns: aTableColumnArray [

	aTableColumnArray do: [ :column |
			| columnElement |
			columnElement := ToTableHeaderRulerCell new
				                 initializeFromColumn: column;
				                 yourself.
			self middleContainer addChild: columnElement ]
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderRulerNodeContainer >> newMiddleContainer [

	^ self newLinearContainer hMatchParent; yourself
]

{ #category : #accessing }
ToTableHeaderRulerNodeContainer >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderRulerNodeContainer >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> recordCellsWidth [

	| last |
	self rulerCells allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self rulerCells last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #initialization }
ToTableHeaderRulerNodeContainer >> removeCheckbox [

	checkbox ifNil: [ ^ self ].
	checkbox removeFromParent
]

{ #category : #accessing }
ToTableHeaderRulerNodeContainer >> rulerCells [ 

	^ self middleContainer children asArray
]

{ #category : #accessing }
ToTableHeaderRulerNodeContainer >> useCheckbox: aBoolean [

	aBoolean
		ifTrue: [ self addCheckbox ]
		ifFalse: [ self removeCheckbox ].
	self requestNewSkin
]
