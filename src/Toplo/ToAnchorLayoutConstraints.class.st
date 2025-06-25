"
I represent the constraints of a `BlProportionalLayout`.
"
Class {
	#name : #ToAnchorLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'operations'
	],
	#category : #'Toplo-Support-Anchor'
}

{ #category : #adding }
ToAnchorLayoutConstraints >> add: anAnchorOperation [

	operations add: anAnchorOperation
]

{ #category : #layout }
ToAnchorLayoutConstraints >> applyOperations: anOperationArray inParent: anElement forChild: aChild in: availableBounds [

	| bnds |
	bnds := aChild margin expand: aChild measuredBounds asRectangle.
	anOperationArray do: [ :op |
			bnds := op
				        appliedOnChildBounds: bnds
				        withParent: anElement
				        inAvailableRectangle: availableBounds ].
	^ aChild margin inset: bnds
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> defaultHorizontal [

	^ ToAnchorLayoutConstraintsHorizontal new
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> defaultVertical [

	^ ToAnchorLayoutConstraintsVertical new
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> initialize [ 

	super initialize.
	operations := OrderedCollection new
]

{ #category : #layout }
ToAnchorLayoutConstraints >> measureInParent: anElement forChild: aChild in: availableBounds [

	^ self
		  applyOperations: self measurementOperations
		  inParent: anElement
		  forChild: aChild
		  in: availableBounds
]

{ #category : #layout }
ToAnchorLayoutConstraints >> measurementOperations [

	^ operations select: [ :op | op isMeasurement ]
]

{ #category : #layout }
ToAnchorLayoutConstraints >> positionInParent: anElement forChild: aChild in: availableBounds [

	^ self
		  applyOperations: self positionOperations
		  inParent: anElement
		  forChild: aChild
		  in: availableBounds
]

{ #category : #layout }
ToAnchorLayoutConstraints >> positionOperations [

	^ operations reject: [ :op | op isMeasurement ]
]
