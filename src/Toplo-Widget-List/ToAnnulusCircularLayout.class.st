Class {
	#name : #ToAnnulusCircularLayout,
	#superclass : #BlBasicLayout,
	#instVars : [
		'innerRadius',
		'outerRadius',
		'startAngle',
		'angularOffset'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #accessing }
ToAnnulusCircularLayout >> angularOffset [

	^ angularOffset
]

{ #category : #accessing }
ToAnnulusCircularLayout >> angularOffset: anObject [

	angularOffset := anObject
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
   angularOffset := 10.
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

	| center radius arcDeg angleDeg |
	anElement children isEmpty ifTrue: [ ^ self ].

	center := anElement measuredBounds center.
	radius := innerRadius + outerRadius / 2.
	arcDeg := 360 / anElement children size.
	angleDeg := startAngle + angularOffset.
	anElement childrenDo: [ :each |
			each geometry
				innerRadius: innerRadius;
				outerRadius: outerRadius;
				startAngle: angleDeg;
				endAngle: angleDeg + arcDeg.
			each measuredExtent: anElement measuredExtent.
			each childrenDo: [ :subChild |
					| centroid edgePoint pointFromCenter |
					centroid := self centroidOf: each in: anElement.
					edgePoint := self
						             pointOnPeripheryFromCenter:
						             anElement measuredBounds center
						             through: centroid
						             in: anElement.
					pointFromCenter := self
						                   pointFromCenter:
						                   anElement measuredBounds center
						                   through: centroid
						                   atDistance: 130.

					"triPoints := self trianglePointsIn: anElement startAngle: angleDeg endAngle: angleDeg + arcDeg.
				subChild geometry vertices: triPoints."
					subChild position:
						pointFromCenter - (subChild measuredExtent // 2)
					"subChild position: ((self centroidOf: each in: anElement)
						- (subChild measuredExtent // 2))" ].
			angleDeg := angleDeg + arcDeg ].
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

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngle [

	^ startAngle
]

{ #category : #accessing }
ToAnnulusCircularLayout >> startAngle: anObject [

	startAngle := anObject
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
