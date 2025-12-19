Trait {
	#name : #TToTableRowNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'t - table node' }
TToTableRowNode >> cellContainers [

	^ self children asArray 
]

{ #category : #'t - table node' }
TToTableRowNode >> cells [ 

	^ self cellContainers collect: [ :cont | cont cell ]
]

{ #category : #'t - table node' }
TToTableRowNode >> columns [

	^ self holder listElement columns
]

{ #category : #'t - table node' }
TToTableRowNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state minWidth column |
	listElement := self holder listElement.
	state := listElement columnStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	column := listElement columns at: aDivider cellIndex.
	minWidth := column minWidth.
	container updateWidthWith: ((state startDragWidth + aDistance) max: minWidth)
]

{ #category : #'t - table node' }
TToTableRowNode >> recordCellsWidth [

	| columns index containers last state |
	columns := self holder listElement columns.
	index := 1.
	containers := self cellContainers.
	containers allButLastDo: [ :cont |
			state := self holder listElement columnStateAt: index.
			cont updateWidthWith: state width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := containers last.
	state := self holder listElement columnStateAt: index.
	last updateWidthWith: state width
]
