Trait {
	#name : #TToTableNode,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'t - table node' }
TToTableNode >> cellContainers [

	^ self children asArray 
]

{ #category : #'t - table node' }
TToTableNode >> cells [ 

	^ self cellContainers collect: [ :cont | cont cell ]
]

{ #category : #'t - table node' }
TToTableNode >> columns [

	^ self holder listElement columns
]

{ #category : #'t - table node' }
TToTableNode >> divider: aDivider movedBy: aDistance from: aStartLocation [

	| container listElement state |
	listElement := self holder listElement.
	state := listElement cellStateAt: aDivider cellIndex.
	container := self cellContainers at: aDivider cellIndex.
	container updateWidthWith: state startDragWidth + aDistance
]

{ #category : #'t - table node' }
TToTableNode >> recordCellsWidth [

	| columns index containers last state |
	columns := self holder listElement columns.
	index := 1.
	containers := self cellContainers.
	containers allButLastDo: [ :cont |
			state := self holder listElement cellStateAt: index.
			cont updateWidthWith: state width.
			index := index + 1 ].
	columns last resizable ifTrue: [ ^ self ].
	last := containers last.
	state := self holder listElement cellStateAt: index.
	last updateWidthWith: state width
]
