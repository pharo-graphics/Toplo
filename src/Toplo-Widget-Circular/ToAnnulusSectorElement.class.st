Class {
	#name : #ToAnnulusSectorElement,
	#superclass : #ToElement,
	#traits : 'TToAnnulusSectorLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait',
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusSectorElement >> centroid [ 

	^ self constraints annulusSector centroid
]

{ #category : #accessing }
ToAnnulusSectorElement >> centroidAnchor [

	^ (self constraints anchors newExplicitReceiverWith: self) centroidAnchor
]

{ #category : #initialization }
ToAnnulusSectorElement >> defaultGeometry [

	^ BlAnnulusSectorGeometry new
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
	self geometry: self defaultGeometry 
]

{ #category : #'t - annulus circular layout user' }
ToAnnulusSectorElement >> stateHolder [

	^ self layout
]
