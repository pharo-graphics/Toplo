Class {
	#name : #ToTripletLayoutHorizontalOrientation,
	#superclass : #ToTripletLayoutOrientation,
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> breadthMode [
	^ self layout cache heightMode
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> breadthProperties: anElement [
	^ anElement constraints vertical
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> breadthSpec: anExtentSpec [
	^ anExtentSpec heightSpec
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> extentBreadth: breadth lengthSpec: length [
	^ length @ breadth
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> extentSpecBreadth: breadthSpec lengthSpec: lengthSpec [

	^ BlExtentMeasurementSpec
		  widthSpec: lengthSpec
		  heightSpec: breadthSpec
]

{ #category : #factory }
ToTripletLayoutHorizontalOrientation >> inverted [

	^ ToTripletLayoutVerticalOrientation new
]

{ #category : #testing }
ToTripletLayoutHorizontalOrientation >> isHorizontal [
	^ true
]

{ #category : #layout }
ToTripletLayoutHorizontalOrientation >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	|top right bottom left majorBounds elementInnerBounds theLayeredChildren  |
	"Layout subnodes vertically in column one by one
	based on previousely measured extent"

	top := anElement padding top.
	left := anElement padding left. 
	right := left.
	bottom := top.

	theLayeredChildren := anElement children accountedByLayout.

	self layout direction
		with: theLayeredChildren
		do: [ :child |
			right := right + child measuredWidth + (child margin width max: 0.0).
			bottom := bottom max: child measuredHeight + (child margin height max: 0.0) ].
	
	majorBounds := (left@top corner: right@bottom).
	elementInnerBounds := anElement padding inset: anElement boundsInLocal.
	majorBounds = elementInnerBounds ifFalse: [
		| translation |
		translation := (self layout horizontalAlignment directed: self layout direction) translationOf: majorBounds in: elementInnerBounds.
		majorBounds := majorBounds translateBy: translation ].

	right := majorBounds right.
	bottom := majorBounds bottom.
	left := majorBounds left.
	top := majorBounds top.
	
	self layout direction
		with: theLayeredChildren
		inject: left @ top
		into: [ :origin :child |
			| childBounds childMarginBounds childConstraints |
			childConstraints := child constraints linear.
			childBounds := origin + (child margin topLeft max: 0.0@0.0) extent: child measuredExtent.
			childMarginBounds := origin extent: child measuredExtent + (child margin extent max: 0.0@0.0).  

			self layout verticalAlignment ifNotNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := self layout verticalAlignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].

			self layout verticalAlignment ifNull: [ 
				| translation allowedBounds |
				allowedBounds := childMarginBounds origin extent: child measuredWidth @ elementInnerBounds height.
				translation := childConstraints vertical alignment translationOf: childMarginBounds in: allowedBounds.
				childBounds := childBounds translateBy: translation ].
			
			"telling each subnode what bounds to use for layouting process.
			Because measuring process does not modify actual extent
			we need to use a measured one"
			child applyLayoutIn: childBounds context: aBlElementBoundsUpdateContext.
			"translating origin horizontally right for next subnode"
			(origin x + child measuredWidth + (child margin width max: 0.0)) @ origin y ]
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> lengthLinearProperties: aChildElement [
	^ aChildElement constraints linear horizontal
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> lengthMode [
	^ self layout cache widthMode
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> lengthProperties: aChildElement [
	^ aChildElement constraints horizontal
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> lengthSpec: anExtentSpec [
	^ anExtentSpec widthSpec
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> marginBreadth: anElement [

	^ anElement margin height
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> marginLength: anElement [

	^ anElement margin width
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> measureChildWithMargin: child parentSpec: anExtentMeasurementSpec breadthUsed: breadthUsed lengthUsed: lengthUsed [
	self layout
		measureChildWithMargins: child
		parentSpec: anExtentMeasurementSpec
		widthUsed: lengthUsed
		heightUsed: breadthUsed
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> measuredBreadth: anElement [
	^ anElement measuredHeight
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> measuredLength: anElement [
	^ anElement measuredWidth
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> minimalBreadth: anElement [
	^ anElement constraints minHeight
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> minimalLength: anElement [
	^ anElement constraints minWidth
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> paddingBreadth: anElement [

	^ anElement padding height
]

{ #category : #orientation }
ToTripletLayoutHorizontalOrientation >> paddingLength: anElement [

	^ anElement padding width
]
