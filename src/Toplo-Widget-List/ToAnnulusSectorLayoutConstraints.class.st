Class {
	#name : #ToAnnulusSectorLayoutConstraints,
	#superclass : #BlBasicLayout,
	#instVars : [
		'centroid',
		'edgePoint'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite-Circular'
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
