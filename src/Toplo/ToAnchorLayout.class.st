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
ToAnchorLayout >> boundsForChild: aChild in: availableBounds [

	^ aChild constraints anchors
		  boundsForChild: aChild
		  in: availableBounds
]

{ #category : #layout }
ToAnchorLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [
	"Layout non-ignoredByLayout children"

	| availableBounds |
	super layout: anElement in: aRectangle context: aBlElementBoundsUpdater.
	availableBounds := anElement padding
		inset: (0.0 @ 0.0 extent: anElement extent).

	anElement children accountedByLayout do: [ :eachChild |
			eachChild
				applyLayoutIn: (self boundsForChild: eachChild in: availableBounds)
				context: aBlElementBoundsUpdater ].

	"Layout ignoredByLayout children"
	self layoutIgnored: anElement context: aBlElementBoundsUpdater
]

{ #category : #measure }
ToAnchorLayout >> measure: anElement with: anExtentSpec [
	super measure: anElement with: anExtentSpec.
	
	self measureIgnored: anElement with: anExtentSpec
]
