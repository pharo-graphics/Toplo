"
I'm a layout that determines the position and extent of each child of an element by taking into account fractions defined in the constraints.

I was initially inspired on Morphic's ProportionalLayout.

Example:
```
	| aContainer childA childB gap |
	gap := 5.

	childA := BlElement new
		id: #childA;
		background: Color red;
		constraintsDo: [ :c |
			c proportional horizontal right: 0.5.
			c margin: (BlInsets all: gap) ];
		yourself.

	childB := BlElement new
		id: #childB;
		background: Color green;
		constraintsDo: [ :c |
			c proportional horizontal left: 0.5.
			c margin: (BlInsets all: gap) ];
		yourself.

	aContainer := BlElement new
		id: #container;
		background: Color blue;
		layout: BlProportionalLayout new;
		size: 100 @ 100;
		addChild: childA;
		addChild: childB;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets all: gap);
		yourself.
	
	aContainer openInNewSpace
```
"
Class {
	#name : #ToAnchorLayout,
	#superclass : #BlLayout,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #constraints }
ToAnchorLayout class >> constraints [

	^ ToAnchorLayoutConstraints new
]

{ #category : #layout }
ToAnchorLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [
	"Layout non-ignoredByLayout children"

	| availableBounds |
	availableBounds := anElement padding
		inset: (0.0 @ 0.0 extent: anElement extent).
	anElement children accountedByLayout do: [ :eachChild |
			eachChild
				applyLayoutIn: (self
						 positionInParent: anElement
						 forChild: eachChild
						 in: availableBounds)
				context: aBlElementBoundsUpdater ].
			
	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #measure }
ToAnchorLayout >> measure: anElement with: anExtentSpec [

	| extent availableBounds |

	super measure: anElement with: anExtentSpec.
	extent := anElement measuredExtent.
	availableBounds := anElement padding inset: (0 @ 0 extent: extent).
	anElement children accountedByLayout do: [ :eachChild |
			| boundsForChild  |

			boundsForChild := self
				                  measureInParent: anElement
				                  forChild: eachChild
				                  in: availableBounds.

			eachChild measure: (BlExtentMeasurementSpec
					 widthSpec: (self
							  measurementSpecFor: anExtentSpec widthSpec
							  usedSize: extent x - boundsForChild width
							  resizer: (BlLayoutResizer exact: boundsForChild width))
					 heightSpec: (self
							  measurementSpecFor: anExtentSpec heightSpec
							  usedSize: extent y - boundsForChild height
							  resizer: (BlLayoutResizer exact: boundsForChild height))) ].
		
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #layout }
ToAnchorLayout >> measureInParent: anElement forChild: aChild in: availableBounds [

	^ aChild constraints anchors
		  measureInParent: anElement
		  forChild: aChild
		  in: availableBounds
]

{ #category : #layout }
ToAnchorLayout >> positionInParent: anElement forChild: aChild in: availableBounds [

	^ aChild constraints anchors
		  positionInParent: anElement
		  forChild: aChild
		  in: availableBounds
]
