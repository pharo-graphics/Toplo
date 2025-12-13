Class {
	#name : #ToTableHeaderRulerCell,
	#superclass : #ToElement,
	#instVars : [
		'state',
		'column'
	],
	#category : #'Toplo-Widget-Table-HeaderRuler'
}

{ #category : #accessing }
ToTableHeaderRulerCell >> column [ 

	^ column
]

{ #category : #initialization }
ToTableHeaderRulerCell >> initialize [ 

	super initialize.
	self hMatchParent.
	self height: 0.
	self background: Color random
]

{ #category : #initialization }
ToTableHeaderRulerCell >> initializeFromColumn: aColumn [

	column := aColumn.
	state := ToTableColumnState new.
	state initializeFromColumn: aColumn.
	column width
		ifNotNil: [ :w | self width: w ]
		ifNil: [ self hMatchParent ]
]

{ #category : #skin }
ToTableHeaderRulerCell >> installRawStyle [ 

	super installRawStyle.
	self padding: (BlInsets
				 horizontal: (self valueOfTokenNamed: #'list-node-padding-H') 
				 vertical: (self valueOfTokenNamed: #'list-node-padding-V'))
]

{ #category : #accessing }
ToTableHeaderRulerCell >> state [ 

	^ state
]

{ #category : #accessing }
ToTableHeaderRulerCell >> updateWidthWith: aNumber [

	state width: aNumber.
	self width: aNumber

]
