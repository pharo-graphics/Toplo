Class {
	#name : #ToAnnulusSectorElement,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-List-InnerList-Finite'
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

{ #category : #accessing }
ToAnnulusSectorElement >> innerRadius [

	^ layout innerRadius
]

{ #category : #accessing }
ToAnnulusSectorElement >> innerRadius: aFloat [

	(self innerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout innerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusSectorElement >> outerRadius [

	^ layout outerRadius
]

{ #category : #accessing }
ToAnnulusSectorElement >> outerRadius: aFloat [

	(self outerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	layout outerRadius: aFloat.
	self requestLayout
]

{ #category : #accessing }
ToAnnulusSectorElement >> startAngle [

	^ layout startAngle
]

{ #category : #accessing }
ToAnnulusSectorElement >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	layout startAngle: anAngleInDegrees.
	self requestLayout
]
