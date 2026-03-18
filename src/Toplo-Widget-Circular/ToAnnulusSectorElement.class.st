Class {
	#name : #ToAnnulusSectorElement,
	#superclass : #ToElement,
	#traits : 'TToAnnulusSectorLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait',
	#instVars : [
		'radialGap'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusSectorElement >> arcLength [

	^ self outerRadius * self deltaAngleInRadians - (self radialGap * 2)
]

{ #category : #accessing }
ToAnnulusSectorElement >> bezierControlPointsForRadius: aRadius withRadialOffset: aRadialOffset [

	^ self
		  bezierControlPointsForRadius: aRadius
		  withStartRadialOffset: aRadialOffset
		  withEndRadialOffset: aRadialOffset
]

{ #category : #accessing }
ToAnnulusSectorElement >> bezierControlPointsForRadius: aRadius withStartRadialOffset: aRadialOffset1 withEndRadialOffset: aRadialOffset2 [

	| r a0 a1 delta k p0 p1 p2 p3 t0 t1 angleOffset1 angleOffset2 |
	r := aRadius.

	"conversion longueur → angle"
	angleOffset1 := aRadialOffset1 + (self radialGap / 2) / r.
	angleOffset2 := aRadialOffset2 + (self radialGap / 2) / r.

	a0 := self startAngle degreesToRadians + angleOffset1.
	a1 := self endAngle degreesToRadians - angleOffset2.

	delta := a1 - a0.
	delta := delta max: 0.

	k := 4.0 / 3.0 * (delta / 4.0) tan.

	"points extrêmes"
	p0 := self bounds center x + (a0 cos * r)
	      @ (self bounds center y + (a0 sin * r)).
	p3 := self bounds center x + (a1 cos * r)
	      @ (self bounds center y + (a1 sin * r)).

	"tangentes"
	t0 := a0 negated sin @ a0 cos.
	t1 := a1 negated sin @ a1 cos.

	"contrôles"
	p1 := p0 + (t0 * (k * r)).
	p2 := p3 - (t1 * (k * r)).

	^ {
		  p0.
		  p1.
		  p2.
		  p3 }
]

{ #category : #accessing }
ToAnnulusSectorElement >> centroid [ 

	^ self constraints annulusSector centroid
]

{ #category : #accessing }
ToAnnulusSectorElement >> centroidAnchor [

	^ (self constraints anchors newExplicitReceiverWith: self) centroidAnchor
]

{ #category : #accessing }
ToAnnulusSectorElement >> chordLength [

	| r |
	r := self outerRadius.
	^ 2 * r * (self deltaAngleInRadians / 2) sin - (self radialGap * 2)
]

{ #category : #initialization }
ToAnnulusSectorElement >> defaultGeometry [

	^ ToAnnulusSectorGeometry new 
]

{ #category : #initialization }
ToAnnulusSectorElement >> defaultLayout [ 

	^ ToAnnulusSectorLayout new
]

{ #category : #accessing }
ToAnnulusSectorElement >> deltaAngleInRadians [
    ^ (self endAngleInRadians - self startAngleInRadians) \\ (2 * Float pi)
]

{ #category : #accessing }
ToAnnulusSectorElement >> edgePoint [ 

	^ self constraints annulusSector edgePoint
]

{ #category : #accessing }
ToAnnulusSectorElement >> edgePointAnchor [

	^ (self constraints anchors newExplicitReceiverWith: self) edgePointAnchor
]

{ #category : #accessing }
ToAnnulusSectorElement >> endAngle [

	^ layout endAngle
]

{ #category : #accessing }
ToAnnulusSectorElement >> endAngle: anAngleInDegrees [

	(self endAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout endAngle: anAngleInDegrees.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusSectorElement >> endAngleInRadians [

	^ self endAngle degreesToRadians 
]

{ #category : #initialization }
ToAnnulusSectorElement >> initialize [

	super initialize.
	radialGap := 0.
	self geometry: self defaultGeometry 
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerArcLength [

	^ (self innerRadius * self deltaAngleInRadians) - (self radialGap * 2)
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerChordLength [

	 | r |
    r := self innerRadius.
    ^ (2 * r * (self deltaAngleInRadians / 2) sin) - (self radialGap * 2)
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerEdgePoint [ 

	^ self constraints annulusSector innerEdgePoint
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerRadius [ 

	^ (self width/2) * self innerRadialRatio 
]

{ #category : #accessing }
ToAnnulusSectorElement >> midAngleInRadians [
    ^ self startAngleInRadians + (self deltaAngleInRadians / 2)
]

{ #category : #initialization }
ToAnnulusSectorElement >> newGeometry [

	^ self defaultGeometry
		  radialGap: radialGap;
		  yourself
]

{ #category : #accessing }
ToAnnulusSectorElement >> outerRadius [ 

	^ (self width/2) * self outerRadialRatio 
]

{ #category : #accessing }
ToAnnulusSectorElement >> radialGap [

	^ radialGap ifNil: [ 0 ]
]

{ #category : #accessing }
ToAnnulusSectorElement >> radialGap: aNumber [

	radialGap = aNumber ifTrue: [ ^ self ].
	radialGap := aNumber.
	self geometry: self newGeometry 
	
]

{ #category : #accessing }
ToAnnulusSectorElement >> startAngleInRadians [

	^ self startAngle degreesToRadians 
]

{ #category : #'t - annulus circular layout user' }
ToAnnulusSectorElement >> stateHolder [

	^ self layout
]
