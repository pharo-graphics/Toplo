Trait {
	#name : #TToTableListElement,
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
TToTableListElement classSide >> parentTable: aTableElement [

	^ self basicNew
		  parentTable: aTableElement;
		  initialize;
		  yourself
]

{ #category : #'t - table list element' }
TToTableListElement >> columnStateAt: anIndex [

	^ parentTable columnStateAt: anIndex
]

{ #category : #'t - table list element' }
TToTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #'t - table list element' }
TToTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray
]

{ #category : #'t - table list element' }
TToTableListElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	self innerElement nodeContainersDo: [ :container |
		container node divider: aDivider movedBy: aDistance from: aStartLocation ]
]

{ #category : #'t - table list element' }
TToTableListElement >> headerCellContainerAt: anIndex [

	^ parentTable header cellContainers at: anIndex
]

{ #category : #'t - table list element' }
TToTableListElement >> initializeAsTableListElement [

	self addStamp: #geometry withValue: BlRectangleGeometry new.
	self initializeScrollBar
]

{ #category : #'t - table list element' }
TToTableListElement >> initializeScrollBar [

	| vscrollBar |
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets left: 10).
			c anchors add: (c anchors topAnchor on: self topAnchor).
			c anchors add: (c anchors leftAnchor on: self rightAnchor - 3).
			c anchors add: (c anchors heightAnchor on: self heightAnchor) ].
	vscrollBar attachTo: self innerElement.
	vscrollBar elevation: (BlRelativeElevation elevation: 20).
	parentTable addChild: vscrollBar
]

{ #category : #'t - table list element' }
TToTableListElement >> parentTable [

	^ parentTable
]

{ #category : #'t - table list element' }
TToTableListElement >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #'t - table list element' }
TToTableListElement >> recordCellsWidth [

	self innerElement nodeContainersDo: [ :container | container node recordCellsWidth ]
]
