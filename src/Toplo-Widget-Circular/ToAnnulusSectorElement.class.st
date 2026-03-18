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

	| delta radius arc |
	delta := self endAngle - self startAngle \\ (2 * Float pi).
	radius := self outerRadialRatio * (self width / 2).
	arc := radius * delta.
	^ arc
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

	| delta chord |
	delta := self endAngle - self startAngle \\ (2 * Float pi).
	chord := 2 * (self outerRadialRatio * self width / 2)
	         * (delta / 2) sin.
	^ chord
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

{ #category : #initialization }
ToAnnulusSectorElement >> initialize [

	super initialize.
	radialGap := 0.
	self geometry: self defaultGeometry 
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerArcLength [

	| delta radius arc |
	delta := self endAngle - self startAngle \\ (2 * Float pi).
	radius := self innerRadialRatio * (self width / 2).
	arc := radius * delta.
	^ arc
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerChordLength [

	| delta chord |
	delta := self endAngle - self startAngle \\ (2 * Float pi).
	chord := 2 * (self innerRadialRatio * self width / 2)
	         * (delta / 2) sin.
	^ chord
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerEdgePoint [ 

	^ self constraints annulusSector innerEdgePoint
]

{ #category : #initialization }
ToAnnulusSectorElement >> newGeometry [

	^ self defaultGeometry
		  radialGap: radialGap;
		  yourself
]

{ #category : #accessing }
ToAnnulusSectorElement >> radialGap [

	^ radialGap
]

{ #category : #accessing }
ToAnnulusSectorElement >> radialGap: aNumber [

	radialGap = aNumber ifTrue: [ ^ self ].
	radialGap := aNumber.
	self geometry: self newGeometry 
	
]

{ #category : #'t - annulus circular layout user' }
ToAnnulusSectorElement >> stateHolder [

	^ self layout
]
