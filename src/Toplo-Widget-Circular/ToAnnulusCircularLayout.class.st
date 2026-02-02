Class {
	#name : #ToAnnulusCircularLayout,
	#superclass : #BlBasicLayout,
	#instVars : [
		'innerRadius',
		'outerRadius',
		'startAngle',
		'startAngleOffset',
		'uniformSectors'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
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

    maxRadius := (aContainer measuredExtent x min: aContainer measuredExtent y) / 2.
    realInner := self innerRadius * maxRadius.
    realOuter := self outerRadius * maxRadius.
    r := (realInner + realOuter) / 2.

    midAngle := (geom startAngle + geom endAngle) / 2.
    angleRad := midAngle degreesToRadians.

    ^ center + ((r * angleRad cos) @ (r * angleRad sin))
]

{ #category : #initialization }
ToAnnulusCircularLayout >> initialize [

	super initialize.
	innerRadius := 0.
	outerRadius := 1.
	startAngle := 0.
	startAngleOffset := 0.
	uniformSectors := true
]

{ #category : #accessing }
ToAnnulusCircularLayout >> innerRadius [

	^ innerRadius
]

{ #category : #accessing }
ToAnnulusCircularLayout >> innerRadius: anObject [

	innerRadius := anObject
]

{ #category : #layout }
ToAnnulusCircularLayout >> layout: anElement in: aBounds context: aBlElementBoundsUpdateContext [

	| radius angleGap angleDeg |
	anElement children isEmpty ifTrue: [ ^ self ].

	radius := innerRadius + outerRadius / 2.
	angleGap := 360 / anElement children size.
	angleDeg := startAngle + startAngleOffset.

	anElement childrenDo: [ :each |
			| centroid edgePoint pointFromCenter |
			centroid := self centroidOf: each in: anElement.
			edgePoint := self
				             pointOnPeripheryFromCenter:
				             anElement measuredBounds center
				             through: centroid
				             in: anElement.

			each constraints annulusSector centroid: centroid.
			each constraints annulusSector edgePoint: edgePoint.
			each extent: anElement measuredExtent.

			uniformSectors ifFalse: [
				angleGap := each constraints annulus expliciteAngleGap ].
			each
				innerRadius: innerRadius;
				outerRadius: outerRadius;
				startAngle: angleDeg;
				endAngle: angleDeg + angleGap.
			angleDeg := angleDeg + angleGap.

			pointFromCenter := self
				                   pointFromCenter:
				                   anElement measuredBounds center
				                   through: centroid
				                   atDistance: 100 ].
	super
		layout: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext.
	anElement invalidate
]

{ #category : #accessing }
ToAnnulusCircularLayout >> outerRadius [

	^ outerRadius
]

{ #category : #accessing }
ToAnnulusCircularLayout >> outerRadius: anObject [

	outerRadius := anObject
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
ToAnnulusCircularLayout >> position: aPoint aroundCentroidOf: aChild in: anElement [ 
    | centroid |

    centroid := self centroidOf: aChild in: anElement.
    ^ (centroid - aPoint)
]

{ #category : #private }
ToAnnulusCircularLayout >> positionAroundCentroidOf: aChild in: anElement [ 
    | centroid |

    centroid := self centroidOf: aChild in: anElement.
    ^ (centroid - (aChild measuredPosition / 2))
]

{ #category : #private }
ToAnnulusCircularLayout >> readableTextRotationForAngle: angleDeg [
    | a |

    a := angleDeg \\ 360.

    (a > 90 and: [ a < 270 ])
        ifTrue: [ ^ angleDeg + 180 ]
        ifFalse: [ ^ angleDeg ]
]

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngle [

	^ startAngle
]

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngle: anObject [

	startAngle := anObject
]

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngleOffset [

	^ startAngleOffset
]

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngleOffset: anObject [

	startAngleOffset := anObject
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
