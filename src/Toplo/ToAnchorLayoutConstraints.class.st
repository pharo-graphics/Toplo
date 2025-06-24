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

{ #category : #'instance creation' }
ToAnchorLayoutConstraints >> bottomAnchor [

	^ ToElementBottomAnchor new
]

{ #category : #layout }
ToAnchorLayoutConstraints >> boundsForChild: aChild in: availableBounds [

	| bnds |
	bnds := aChild measuredBounds asRectangle.
	operations do: [ :op | bnds := op applyOnChildBounds: bnds in: availableBounds ].
	^ bnds
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> initialize [ 

	super initialize.
	operations := OrderedCollection new
]

{ #category : #'instance creation' }
ToAnchorLayoutConstraints >> leftAnchor [

	^ ToElementLeftAnchor new
]

{ #category : #'instance creation' }
ToAnchorLayoutConstraints >> rightAnchor [

	^ ToElementRightAnchor new
]

{ #category : #'instance creation' }
ToAnchorLayoutConstraints >> topAnchor [

	^ ToElementTopAnchor new
]
