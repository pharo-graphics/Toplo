Class {
	#name : #ToAnnulusCircularLayout,
	#superclass : #BlBasicLayout,
	#traits : 'TToAnnulusSectorLayoutState',
	#classTraits : 'TToAnnulusSectorLayoutState classTrait',
	#category : #'Toplo-Widget-Circular'
}

{ #category : #constraints }
ToAnnulusCircularLayout class >> constraints [

	^ ToAnnulusCircularLayoutConstraints new
]

{ #category : #private }
ToAnnulusCircularLayout >> angleDegFrom: center to: point [
    | v angleRad angleDeg |

    v := point - center.
    v isZero ifTrue: [ ^ 0 ].

    angleRad := v y arcTan: v x.
    angleDeg := angleRad radiansToDegrees.

    angleDeg < 0 ifTrue: [ angleDeg := angleDeg + 360 ].
    ^ angleDeg
]

{ #category : #private }
ToAnnulusCircularLayout >> boundingBoxAroundCentroidOf: anElement in: aContainer withSize: aSize [
    | centroid |

    centroid := self centroidOf: anElement in: aContainer.
    ^ (centroid - (aSize / 2)) extent: aSize
]

{ #category : #private }
ToAnnulusCircularLayout >> centroidOf: anElement in: aContainer [

	| geom center midAngle r angleRad realInner realOuter maxRadius |
	geom := anElement geometry.
	center := aContainer measuredBounds center.

	maxRadius := (aContainer measuredExtent x min:
		              aContainer measuredExtent y) / 2.
	realInner := self innerRadialRatio * maxRadius.
	realOuter := self outerRadialRatio * maxRadius.
	r := realInner + realOuter / 2.

	midAngle := geom startAngle + geom endAngle / 2.
	angleRad := midAngle degreesToRadians.

	^ center + (r * angleRad cos @ (r * angleRad sin))
]

{ #category : #layout }
ToAnnulusCircularLayout >> layout: anElement in: aBounds context: aBlElementBoundsUpdateContext [

	| radius defaultGap sectorStartAngle remainder sectors numberWithGap |
	sectors := anElement children accountedByLayout.
	sectors isEmpty ifTrue: [ ^ self ].

	radius := aBounds extent x / 2.
	remainder := 360.
	numberWithGap := 0.
	sectors do: [ :each |
			(each constraints annulus
				 sectorAngleInDegreesWithRadius: radius
				 inSectorElement: each) ifNotNil: [ :gap |
					remainder := remainder - gap.
					numberWithGap := numberWithGap + 1 ] ].

	defaultGap := numberWithGap < sectors size
		              ifTrue: [ remainder / (sectors size - numberWithGap) ]
		              ifFalse: [ 0 ].
	sectorStartAngle := self startAngle + self startAngleOffset.

	sectors do: [ :each |
			| centroid edgePoint pointFromCenter sectorGap |
			centroid := self centroidOf: each in: anElement.
			edgePoint := self
				             pointOnPeripheryFromCenter: aBounds center
				             through: centroid
				             in: anElement.

			each constraints annulusSector centroid: centroid.
			each constraints annulusSector edgePoint: edgePoint.
			each extent: anElement measuredExtent.

			sectorGap := (each constraints annulus
				              sectorAngleInDegreesWithRadius: radius
				              inSectorElement: each)
				             ifNotNil: [ :gap | gap ]
				             ifNil: [ defaultGap ].

			each
				innerRadialRatio: self innerRadialRatio;
				outerRadialRatio: self outerRadialRatio;
				startAngle: sectorStartAngle;
				endAngle: sectorStartAngle + sectorGap.
			sectorStartAngle := sectorStartAngle + sectorGap.

			pointFromCenter := self
				                   pointFromCenter: aBounds center
				                   through: centroid
				                   atDistance: 100 ].
	super
		layout: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext.
	anElement invalidate
]

{ #category : #private }
ToAnnulusCircularLayout >> pointFromCenter: center through: centroid atDistance: d [

	| direction unit |
	direction := centroid - center.
	direction isZero ifTrue: [ ^ center ].

	unit := direction normalized.
	^ center + (unit * d)
]

{ #category : #private }
ToAnnulusCircularLayout >> pointFromCentroid: centroid awayFromCenter: center atDistance: d [

	| direction unit |
	direction := centroid - center.
	direction isZero ifTrue: [ ^ centroid ].

	unit := direction normalized.
	^ centroid + (unit * d)
]

{ #category : #private }
ToAnnulusCircularLayout >> pointOnPeripheryFromCenter: center through: centroid in: container [

	| direction unit maxRadius |
	direction := centroid - center.
	direction isZero ifTrue: [ ^ center ].

	unit := direction normalized.

	maxRadius := (container bounds extent x min:
		              container bounds extent y) / 2.

	^ center + (unit * maxRadius)
]

{ #category : #private }
ToAnnulusCircularLayout >> radialInnerIntersectionPointAtAngle: anAngleInDegrees in: anAnnulus [

	^ (self radialIntersectionPointsAtAngle: anAngleInDegrees in: anAnnulus) first
]

{ #category : #private }
ToAnnulusCircularLayout >> radialIntersectionPointsAtAngle: anAngleInDegrees in: anAnnulus [

	| center direction containerRadius inner outer |
	center := anAnnulus measuredBounds center.

	direction := anAngleInDegrees degreesToRadians cos
	             @ anAngleInDegrees degreesToRadians sin.

	containerRadius := anAnnulus measuredBounds extent min / 2.

	inner := self innerRadialRatio * containerRadius.
	outer := self outerRadialRatio * containerRadius.

	^ {
		  (center + (direction * inner)).
		  (center + (direction * outer)) }
]

{ #category : #private }
ToAnnulusCircularLayout >> radialOuterIntersectionPointAtAngle: anAngleInDegrees in: anAnnulus [

	^ (self radialIntersectionPointsAtAngle: anAngleInDegrees in: anAnnulus) second
]

{ #category : #private }
ToAnnulusCircularLayout >> readableTextRotationForAngle: angleDeg [
    | a |

    a := angleDeg \\ 360.

    (a > 90 and: [ a < 270 ])
        ifTrue: [ ^ angleDeg + 180 ]
        ifFalse: [ ^ angleDeg ]
]

{ #category : #private }
ToAnnulusCircularLayout >> trianglePointsIn: container startAngle: aStartAngle endAngle: aEndAngle [

	| maxRadius realInner realOuter center pCenter pStart pEnd |
	maxRadius := (container measuredExtent x min:
		              container measuredExtent y) / 2.
	realInner := self innerRadius * maxRadius.
	realOuter := self outerRadius * maxRadius.
	center := container measuredBounds center.

	pCenter := center.
	pStart := center + (realOuter * aStartAngle degreesToRadians cos
	           @ (realOuter * aStartAngle degreesToRadians sin)).
	pEnd := center + (realOuter * aEndAngle degreesToRadians cos
	         @ (realOuter * aEndAngle degreesToRadians sin)).

	^ {
		  pCenter.
		  pStart.
		  pEnd }
]
