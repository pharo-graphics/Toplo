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

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> bottomAnchor [

	^ ToElementBottomAnchor new
]

{ #category : #layout }
ToAnchorLayoutConstraints >> boundsForChild: aChild in: availableBounds [

	| bnds |
	bnds := aChild margin expand: aChild measuredBounds asRectangle.
	operations do: [ :op | bnds := op applyOnChildBounds: bnds in: availableBounds ].
	^ aChild margin inset: bnds
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> centerAnchor [

	^ ToElementCenterAnchor new
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> defaultHorizontal [

	^ ToAnchorLayoutConstraintsHorizontal new
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> defaultVertical [

	^ ToAnchorLayoutConstraintsVertical new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> heightAnchor [

	^ self vertical breadthAnchor 
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> horizontalCenterAnchor [

	^ self horizontal centerAnchor 
]

{ #category : #initialization }
ToAnchorLayoutConstraints >> initialize [ 

	super initialize.
	operations := OrderedCollection new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> leftAnchor [

	^ ToElementLeftAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> rightAnchor [

	^ ToElementRightAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> topAnchor [

	^ ToElementTopAnchor new
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> verticalCenterAnchor [

	^ self vertical centerAnchor 
]

{ #category : #'anchor creation' }
ToAnchorLayoutConstraints >> widthAnchor [

	^ self horizontal breadthAnchor 
]
