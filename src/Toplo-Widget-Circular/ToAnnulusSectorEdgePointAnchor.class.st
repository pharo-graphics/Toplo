Class {
	#name : #ToAnnulusSectorEdgePointAnchor,
	#superclass : #BlElementLocationAnchor,
	#instVars : [
		'offset',
		'outerEdge'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #applying }
ToAnnulusSectorEdgePointAnchor >> appliedOnRectangle: aRectangle withValue: aValue [

	| pt |
	pt := self valueInBounds: aRectangle.
	^ BlBounds origin: pt extent: aRectangle extent
]

{ #category : #initialization }
ToAnnulusSectorEdgePointAnchor >> initialize [ 

	super initialize.
	outerEdge := true
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> innerEdge [

	^ self outerEdge not
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> innerEdge: aBoolean [

	self outerEdge: aBoolean not
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> offset [

	^ offset ifNil: [ offset := 0 ]
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> offset: aNumber [

	offset := aNumber
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> outerEdge [

	^ outerEdge
]

{ #category : #accessing }
ToAnnulusSectorEdgePointAnchor >> outerEdge: aBoolean [

	outerEdge := aBoolean
]

{ #category : #applying }
ToAnnulusSectorEdgePointAnchor >> pointAwayFromCenter: center atDistance: d [

	| direction unit edgePoint |
	edgePoint := self outerEdge
		             ifTrue: [ self element edgePoint ]
		             ifFalse: [ self element innerEdgePoint ].
	direction := edgePoint - center.
	direction isZero ifTrue: [ ^ edgePoint ].

	unit := direction normalized.
	^ edgePoint + (unit * d)
]

{ #category : #applying }
ToAnnulusSectorEdgePointAnchor >> valueInBounds: aBounds [

	^ self pointAwayFromCenter: aBounds center atDistance: self offset 
]
