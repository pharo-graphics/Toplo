Class {
	#name : #ToAnnulusSectorLayoutConstraints,
	#superclass : #BlBasicLayout,
	#instVars : [
		'centroid',
		'edgePoint',
		'middleAngle',
		'innerEdgePoint'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> centroid [

	^ centroid ifNil: [ 0 @ 0 ]
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> centroid: anObject [
 
	centroid := anObject
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> edgePoint [

	^ edgePoint ifNil: [ 0 @ 0 ]
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> edgePoint: anObject [

	edgePoint := anObject
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> innerEdgePoint [

	^ innerEdgePoint ifNil: [ 0 @ 0 ]
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> innerEdgePoint: anObject [

	innerEdgePoint := anObject
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> middleAngle [

	^ middleAngle 
]

{ #category : #accessing }
ToAnnulusSectorLayoutConstraints >> middleAngle: anAngleInDegrees [

	middleAngle := anAngleInDegrees
]
