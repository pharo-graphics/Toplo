"
I represent how header should be render. The disposition should be similar to what List have (for the size of the columns)
"
Class {
	#name : #ToTableHeaderElement,
	#superclass : #ToTripletContainer,
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #initialization }
ToTableHeaderElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :e |
						BlInsets
							horizontal: (e valueOfTokenNamed: #'list-padding-H')
							vertical: (e valueOfTokenNamed: #'list-padding-V') ] ]
]

{ #category : #accessing }
ToTableHeaderElement >> cellContainers [

	^ self selectChildrenWithId: #headerCellContainer
]

{ #category : #accessing }
ToTableHeaderElement >> columns: aTableColumnArray [

	self removeCellContainers.
	aTableColumnArray do: [ :column |
			| cellContainer |
			cellContainer := self newCellContainerInColumn: column.
			self middleContainer addChild: cellContainer ]
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	|  cont |
	cont := self cellContainers at: aDivider cellIndex.
	cont updateWidthWith: cont state startDragWidth + aDistance
]

{ #category : #accessing }
ToTableHeaderElement >> divider: aDivider startDragAt: aDistance [

	|  cont |
	cont := self cellContainers at: aDivider cellIndex.
	cont state startDragWidth: cont width
]

{ #category : #initialization }
ToTableHeaderElement >> initialize [

	super initialize.
	self vFitContent.
	self hMatchParent.
	self addEventHandler: ToTableHeaderElementEventHandler new
]

{ #category : #initialization }
ToTableHeaderElement >> newCellContainerInColumn: aColumn [

	^ (ToTableHeaderCellContainer column: aColumn)
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  initializeFromColumnInTableElement: parentTable;
		  yourself
]

{ #category : #'t - triplet container - instance creation' }
ToTableHeaderElement >> newMiddleContainer [

	^ self newLinearContainer
		  hMatchParent;
		  yourself
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTableHeaderElement >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTableHeaderElement >> recordCellsWidth [

	| last |
	self cellContainers allButLastDo: [ :e | e updateWidthWith: e width ].
	last := self cellContainers last.
	last column resizable ifTrue: [ ^ self ].
	last updateWidthWith: last width
]

{ #category : #accessing }
ToTableHeaderElement >> removeCellContainers [

	self cellContainers do: [ :c | c removeFromParent ]
]
