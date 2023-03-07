"
I am a Morph that contain visible rows in a ToFTTableMorph. 

Description 
------------------

I am the main Morph of the FastTable that is responsible of displaying all the rows of a Table. 
My owner need to be a ToFTTableMorph and I will use his dataSource to display the needed informations.

Public API and Key Messages
-----------------
		
- #updateAllRows 

- #updateExposedRows

- #ipdateHeaderRow
 
Internal Representation and Key Implementation Points.
----------------

    Instance Variables
	exposedRows:		A dictionary of index/row with all the exposed rows.
	headerRow:			When not nil contains the header row of the container.
	needsRefreshExposedRows:		A boolean that is true if the container need a refresh.
	startColumnIndex: An integer - first column to start drawing when scrolling horizontally, nil/0 - old behaviour (no scrolling)

The method #drawOn: is responsible of my rendering.
"
Class {
	#name : #ToFTTableContainerMorph,
	#superclass : #Morph,
	#instVars : [
		'needsRefreshExposedRows',
		'headerRow',
		'exposedRows',
		'startColumnIndex',
		'rowColors'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #accessing }
ToFTTableContainerMorph class >> rowLeftMargin [
	"I'm keeping a small margin beween the list and the begining of a row, to enhance visibility."
	^ 1
]

{ #category : #drawing }
ToFTTableContainerMorph >> addResizeSplitters [
	| columnWidths nextColumn delta |
	columnWidths := self calculateColumnWidths.
	nextColumn := self left.
	delta := ToFTColumnResizerMorph resizerWidth / 2.
	self table columns overlappingPairsWithIndexDo:  [ :leftColumn :rightColumn :index |
		nextColumn := nextColumn + (columnWidths at: index) + self table intercellSpacing x.
		self addMorph: ((ToFTColumnResizerMorph
			container: self
				left: (ToFTDisplayColumn column: leftColumn width: (columnWidths at: index))
				right: (ToFTDisplayColumn column: rightColumn width: (columnWidths at: (index + 1))))
			bounds: ((nextColumn - delta)@(self top) extent: delta@(self height));
			color: Color transparent;
			yourself)	 ]
]

{ #category : #updating }
ToFTTableContainerMorph >> adjustToHorizontalScrollBarValue: aNumber [
	| newStartColumnIndex |
	newStartColumnIndex := (self table numberOfColumns * aNumber) rounded
		min: self table numberOfColumns
		max: 1 .
	newStartColumnIndex ~= self startColumnIndex
		ifTrue: [
			self startColumnIndex: newStartColumnIndex.
			self changed  ]
]

{ #category : #drawing }
ToFTTableContainerMorph >> alternateRowsColor [
	rowColors := Array
		with: self theme backgroundColor lighter
		with: self theme backgroundColor darker
]

{ #category : #private }
ToFTTableContainerMorph >> calculateColumnWidths [
	"do three runs
	- first collect defined columnwidth that fit
	- collect remaining undefined columnwidth
	- return if all fit
	  or collect and distribute remaining width.

   the method was adjusted to distribute space starting from startColumnIndex
	to enable horizontal scrolling when columns do not fit the window,
	see #columnOrderOfWidthDistribution"
	| undefinedColumnWidths widths remainingWidth |

	remainingWidth := self table width - self table verticalScrollBarWidth.

	widths := Array new: self table numberOfColumns withAll: 0.
	self columnOrderOfWidthDistribution do: [ :idx || column columnWidth |
		column := self table columns at: idx.
		columnWidth := column acquireWidth: remainingWidth.
		widths at: idx put: columnWidth.
		remainingWidth := remainingWidth - columnWidth ].

	undefinedColumnWidths := widths count: #isZero.
	undefinedColumnWidths isZero
		ifTrue: [ widths size > 1 ifTrue: [ "Set the remaining space to the last column" widths at: widths size put: widths last + remainingWidth ].
			^ widths ].


	"collect and distribute remaining space"
	self columnOrderOfWidthDistribution do: [ :idx |
		(widths at: idx) = 0 	ifTrue: [ widths at: idx put: (remainingWidth / undefinedColumnWidths) ] ].
	^widths
]

{ #category : #private }
ToFTTableContainerMorph >> calculateExactVisibleRows [
	"Answer the rows to show in list - with possible fraction"

	| visibleRows |
	visibleRows := self height / (self table rowHeight + self table intercellSpacing y).
	^ headerRow
		ifNotNil: [ visibleRows - 1 ]
		ifNil: [ visibleRows ]
]

{ #category : #private }
ToFTTableContainerMorph >> calculateMaxVisibleRows [
	"Answer the maximal number of rows to shown in list"

	^ self calculateExactVisibleRows ceiling
]

{ #category : #private }
ToFTTableContainerMorph >> calculateMinVisibleRows [
	"Answer the minimal fully visible number of rows to shown in list"

	^ self calculateExactVisibleRows floor
]

{ #category : #private }
ToFTTableContainerMorph >> calculateStartIndexWhenShowing: visibleRows [
	"Answer the first row to show when showing visibleRows rows.
	 This works in case we are exceeding the available rows to show"
	| currentIndex startIndex oldIndex |

	currentIndex := self table showIndex.
	currentIndex + visibleRows - 1 > self table numberOfRows
		ifTrue: [ currentIndex := self table numberOfRows - visibleRows + 2 ].
	startIndex := currentIndex max: 1.
	oldIndex := self table showIndex.
	self table basicMoveShowIndexTo: startIndex.
	self table announceScrollChangedFrom: oldIndex to: self table showIndex.
	^ startIndex
]

{ #category : #private }
ToFTTableContainerMorph >> calculateVisibleRows [
	"Answer the rows to show in list.
	 Ensures we show the maximum amount possible"

	^ self calculateMaxVisibleRows min: self table numberOfRows
]

{ #category : #testing }
ToFTTableContainerMorph >> canRefreshValues [
	^ self needsRefreshExposedRows and: [ self table isNotNil and: [ self table hasDataSource ] ]
]

{ #category : #updating }
ToFTTableContainerMorph >> changed [
	self table ifNil: [ ^ self ].
	self setNeedsRefreshExposedRows.
	super changed
]

{ #category : #drawing }
ToFTTableContainerMorph >> clipSubmorphs [

	^ true
]

{ #category : #private }
ToFTTableContainerMorph >> columnOrderOfWidthDistribution [
	"returns column indexes ordered by priority to get screenspace"
	| idxToLast idxToFirstReversed |
	self startColumnIndex isZero "a special case implementing default/current behaviour -- natural order of columns starting from the first one"
		ifTrue: [ ^(1 to: self table numberOfColumns) ].
	"new behaviour intended to garantee the visibility of columns around startColumnIndex
		first give width starting from startColumnIndex towards end,
		then from previous available column towards beginning"
	idxToLast := startColumnIndex to: self table numberOfColumns.
	idxToFirstReversed := startColumnIndex>1 ifTrue: [startColumnIndex-1 to: 1 by: -1] ifFalse: [#()].
	^idxToLast,idxToFirstReversed
]

{ #category : #private }
ToFTTableContainerMorph >> createResizableHeaderWith: aMorph between: leftColumn and: rightColumn [
	"Create a wrapper morph with a resizable morph et the left (so we bind two columns).
	 This morph will be completely transparent in all terms... it acts just as a container."
	^ Morph new
		color: Color transparent;
		clipSubmorphs: true;
		layoutPolicy: ToFTRowLayout new;
		bounds: aMorph bounds;
		addMorphBack: (ToFTColumnResizerMorph
			container: self
			left: leftColumn
			right: rightColumn);
		addMorphBack: aMorph;
		yourself
]

{ #category : #initialization }
ToFTTableContainerMorph >> defaultColor [

	^Color transparent
]

{ #category : #drawing }
ToFTTableContainerMorph >> drawOn: canvas [

	super drawOn: canvas.
	self drawRowsOn: canvas
]

{ #category : #drawing }
ToFTTableContainerMorph >> drawOnAthensCanvas: anAthensCanvas [
	self drawOnCanvasWrapperFor: anAthensCanvas
]

{ #category : #drawing }
ToFTTableContainerMorph >> drawRowsOn: canvas [
	| x y cellWidth cellHeight rowsToDisplay rowSubviews highligtedIndexes primarySelectionIndex |

	self canRefreshValues ifFalse: [ ^ self ].	"Nothing to update yet"

	x := self left + self class rowLeftMargin.
	y := self top.
	cellWidth := self width - self class rowLeftMargin.
	cellHeight := self table rowHeight rounded.
	highligtedIndexes := self table selectedIndexes, self table highlightedIndexes.
	primarySelectionIndex := self table selectedIndex.

	"For some superweird reason, calling #calculateExposedRows here instead in #changed (where
	 it should be called) is 10x faster. Since the whole purpose of this component is speed, for
	 now I'm calling it here and adding the #setNeedRecalculateRows mechanism.
	 History, please forgive me."
	self updateAllRows.

	rowsToDisplay := self exposedRows.
	rowSubviews := OrderedCollection new: rowsToDisplay size + 1.
	headerRow ifNotNil: [
		headerRow bounds: (self left @ y extent: self width @ cellHeight).
		y := y + cellHeight + self table intercellSpacing y.
		rowSubviews add: headerRow ].

	rowsToDisplay keysAndValuesDo: [ :rowIndex :row |
		| visibleHeight |
		visibleHeight := (self rowHeight: rowIndex default: cellHeight) min: self bottom - y.
		row bounds: (x @ y extent: cellWidth @ visibleHeight).
		y := y + visibleHeight + self table intercellSpacing y.

		rowSubviews add: row.
		self setColorRow: row index: rowIndex.

		(self table selectionModeStrategy
				selectablesToHighlightFromRow: row
				at: rowIndex
				withHighlightedIndexes: highligtedIndexes
				andPrimaryIndex: primarySelectionIndex)
			keysAndValuesDo: [ :morph :isPrimary |
				morph selectionColor: (self table colorForSelection: isPrimary) ] ].

	"We should notify existing rows about deletion and new rows about insertion.
	It is required to correctly manage stepping animation of cells"
	submorphs do: [ :each |
		each
			privateOwner: nil;
			outOfWorld: self world ].
	submorphs := rowSubviews asArray.
	submorphs do: [ :each | each intoWorld: self world ].

	self table isResizable ifTrue: [ self addResizeSplitters ].

	needsRefreshExposedRows := false
]

{ #category : #private }
ToFTTableContainerMorph >> exposedColumnsRange: columnWidths [
	"Return a subset of indexes for columns which are to be drawn.
	startColumnIndex=0 is default/current behaviour -- draw all, even if they will not fit
	otherwise, we select only indexes of columns having non-zero screen width"

	^self startColumnIndex isZero
		ifTrue: [1 to: self table numberOfColumns]
		ifFalse: [(1 to: columnWidths size) select: [ :idx | (columnWidths at: idx)>0 ]  ]
]

{ #category : #private }
ToFTTableContainerMorph >> exposedRows [
	"Answer a dictionary of rowIndex->row pairs"

	^ exposedRows
]

{ #category : #accessing }
ToFTTableContainerMorph >> firstVisibleRowIndex [

	^ self exposedRows
		ifNotEmpty: [ :rows | rows keys first ]
		ifEmpty: [ 0 ]
]

{ #category : #accessing }
ToFTTableContainerMorph >> headerRow [

	^ headerRow
]

{ #category : #initialization }
ToFTTableContainerMorph >> initialize [
	super initialize.
	needsRefreshExposedRows := false.
	startColumnIndex :=0
]

{ #category : #testing }
ToFTTableContainerMorph >> isRowIndexExceding: rowIndex [
	| headerPresentModificator nextRowIndexByPosition heightWithSpacing |

	headerPresentModificator := headerRow ifNotNil: [ 1 ] ifNil: [ 0 ].
	nextRowIndexByPosition := rowIndex - self table showIndex + 1 + headerPresentModificator.
	heightWithSpacing := self table rowHeight + self table intercellSpacing y.

	^ (nextRowIndexByPosition * heightWithSpacing) > self height
]

{ #category : #testing }
ToFTTableContainerMorph >> isRowIndexFullyVisible: rowIndex [
	"Answer if a row is *fully* visible. That means row is completely visible (there is
	 not hidden part)"
	^ (self isRowIndexVisible: rowIndex)
		and: [ (self isRowIndexExceding: rowIndex) not ]
]

{ #category : #testing }
ToFTTableContainerMorph >> isRowIndexVisible: rowIndex [
	self exposedRows ifNil: [ ^ false ].
	^ self exposedRows includesKey: rowIndex
]

{ #category : #accessing }
ToFTTableContainerMorph >> lastVisibleRowIndex [

	^ self exposedRows
		ifNotEmpty: [ :rows | rows keys last ]
		ifEmpty: [ 0 ]
]

{ #category : #private }
ToFTTableContainerMorph >> needsRefreshExposedRows [
	^ needsRefreshExposedRows
]

{ #category : #geometry }
ToFTTableContainerMorph >> outerBounds [
	^ self bounds
]

{ #category : #accessing }
ToFTTableContainerMorph >> rowAndColumnIndexContainingPoint: aPoint [
	"answer a tuple containing { rowIndex. columnNumber } to be used for menus, etc.
	 (check senders for references)"

	self exposedRows ifNil: [ ^ { nil. nil. } ].

	self exposedRows keysAndValuesDo: [ :rowIndex :row |
		(row bounds containsPoint: aPoint) ifTrue: [
			row submorphs withIndexDo: [ :each :columnIndex |
				 (each bounds containsPoint: aPoint)
					ifTrue: [ ^ { rowIndex. columnIndex } ] ] ] ].
	^ {nil. nil}
]

{ #category : #private }
ToFTTableContainerMorph >> rowHeight: rowIndex default: aNumber [

	^ aNumber
]

{ #category : #accessing }
ToFTTableContainerMorph >> rowIndexContainingPoint: aPoint [

	self exposedRows ifNil: [ ^ nil ].
	self exposedRows keysAndValuesDo: [ :rowIndex :row |
		(row bounds containsPoint: aPoint)
			ifTrue: [ ^ rowIndex ] ].

	^ nil
]

{ #category : #private }
ToFTTableContainerMorph >> setColorRow: aToFTTableRowMorph index: rowIndex [
	"Set the raw color if needed, e.g. when alternateRowsColor is configured"
	rowColors ifNotNil: [ aToFTTableRowMorph color: (rowColors at: ((rowIndex \\ 2) + 1)) ]
]

{ #category : #private }
ToFTTableContainerMorph >> setNeedsRefreshExposedRows [
	needsRefreshExposedRows := true
]

{ #category : #accessing }
ToFTTableContainerMorph >> startColumnIndex [
	startColumnIndex ifNil: [ startColumnIndex := 0 ].
	^startColumnIndex
]

{ #category : #accessing }
ToFTTableContainerMorph >> startColumnIndex: anObject [
	startColumnIndex := anObject
]

{ #category : #accessing }
ToFTTableContainerMorph >> table [
	^ self owner
]

{ #category : #theme }
ToFTTableContainerMorph >> themeChanged [
	"reset rows color to follow the new theme if needed"
	rowColors ifNotNil: [ self alternateRowsColor ].
	super themeChanged
]

{ #category : #updating }
ToFTTableContainerMorph >> updateAllRows [

	self table isShowColumnHeaders
		ifTrue: [ self updateHeaderRow ]
		ifFalse: [ headerRow := nil ].
	self updateExposedRows
]

{ #category : #updating }
ToFTTableContainerMorph >> updateExposedRows [
	"updated (as #updateHeaderRow also) to draw only subset of columns if horizontal scrolling in use, see #exposedColumnsRange:"
	| visibleRows columns columnWidths startIndex |

	self canRefreshValues ifFalse: [ ^ self ].

	visibleRows := self calculateMaxVisibleRows.
	startIndex := self calculateStartIndexWhenShowing: visibleRows.
	columns := self table columns.
	columnWidths := self calculateColumnWidths.

	exposedRows := SmallDictionary new.
	startIndex to: (startIndex + visibleRows - 1) do: [ :rowIndex |
		(self table dataSource hasElementAt: rowIndex) ifTrue: [
			| row |
			row := ToFTTableRowMorph table: self table.
			(self exposedColumnsRange: columnWidths) do: [ :columnIndex | | cell |
				cell := (self table dataSource
					cellColumn: (columns at: columnIndex)
					row: rowIndex).
				cell width: (columnWidths at: columnIndex).
				row addMorphBack: cell ].
			row privateOwner: self.
			exposedRows at: rowIndex put: row ] ]
]

{ #category : #updating }
ToFTTableContainerMorph >> updateHeaderRow [
	"Recalculates the header row if they are defined.
	 Please, note that If one of the headers is nil, I assume all are nil and I return.
	 This is probably not the best approach, but like that I enforce people defines at least
	 a default if they want headers."
	| columns columnHeaders columnWidths |

	self canRefreshValues ifFalse: [ ^ self ].

	headerRow := nil.
	columns := self table columns.
	columnHeaders := OrderedCollection new.
	columnWidths := self calculateColumnWidths.

	(self exposedColumnsRange: columnWidths)  do: [ :index | | column headerCell columnWidth|
		column := columns at: index.
		columnWidth := columnWidths at: index.
		headerCell :=  self table dataSource headerColumn: column.
		headerCell ifNil: [ ^ self ].
		headerCell
			color: self table headerColor;
			width: columnWidth.
		columnHeaders addLast: headerCell.
		ToFTDisplayColumn column: column width: columnWidth ].

	headerRow := (ToFTTableHeaderRowMorph table: self table)
		privateOwner: self;
		addAllMorphs: columnHeaders;
		yourself
]

{ #category : #accessing }
ToFTTableContainerMorph >> visibleRowMorphAtIndex: index [
	^ self exposedRows at: index
]
