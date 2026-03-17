Class {
	#name : #ToAnnulusSectorGeometry,
	#superclass : #BlAnnulusSectorGeometry,
	#instVars : [
		'radialGap'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #drawing }
ToAnnulusSectorGeometry >> aeApplyTo: aeCanvas element: anElement [

	self radialGap isZero ifTrue: [
		^ super aeApplyTo: aeCanvas element: anElement ].
	
	aeCanvas pathFactory: [ :cairoContext |
			cairoContext
				annulusSectorCenter: self center
				from: self startAngle degreesToRadians
				to: self endAngle degreesToRadians
				innerRadius: self absoluteInnerRadius
				outerRadius: self absoluteOuterRadius
				gap: radialGap ]
]

{ #category : #initialization }
ToAnnulusSectorGeometry >> initialize [ 

	super initialize.
	radialGap := 0
]

{ #category : #private }
ToAnnulusSectorGeometry >> pointFromCenter: center through: centroid atDistance: d [

	| direction unit |
	direction := centroid - center.
	direction isZero ifTrue: [ ^ center ].

	unit := direction normalized.
	^ center + (unit * d)
]

{ #category : #accessing }
ToAnnulusSectorGeometry >> radialGap [

	^ radialGap ifNil: [ 0 ]
]

{ #category : #accessing }
ToAnnulusSectorGeometry >> radialGap: aNumber [

	radialGap := aNumber
]
