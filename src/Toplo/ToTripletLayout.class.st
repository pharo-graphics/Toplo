Class {
	#name : #ToTripletLayout,
	#superclass : #BlLayout,
	#traits : 'TBlAlignable + TBlOrientableLayout',
	#classTraits : 'TBlAlignable classTrait + TBlOrientableLayout classTrait',
	#instVars : [
		'weightSum',
		'verticalAlignment',
		'horizontalAlignment',
		'orientation',
		'shouldUseLargestChild',
		'cellSpacing',
		'direction',
		'interspace'
	],
	#category : #'Toplo-Core-TripletLayout'
}

{ #category : #constraints }
ToTripletLayout class >> constraints [

	^ ToTripletLayoutConstraints new
]

{ #category : #factory }
ToTripletLayout class >> horizontal [
	^ self new beHorizontal
]

{ #category : #factory }
ToTripletLayout class >> vertical [
	^ self new beVertical
]

{ #category : #'api - alignment' }
ToTripletLayout >> align: aChildElement horizontal: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) horizontal alignment: aBlAlignment ]
]

{ #category : #'api - alignment' }
ToTripletLayout >> align: aChildElement vertical: aBlAlignment [
	aChildElement constraintsDo: [ :c | (c at: self class) vertical alignment: aBlAlignment ]
]

{ #category : #accessing }
ToTripletLayout >> alignment [
	^ (self horizontalAlignment + self verticalAlignment) directed: self direction
]

{ #category : #orientation }
ToTripletLayout >> beHorizontal [
	"Change my orientation to horizontal"
	
	self orientation: ToTripletLayoutHorizontalOrientation new
]

{ #category : #orientation }
ToTripletLayout >> beVertical [
	"Change my orientation to vertical"
	
	self orientation: ToTripletLayoutVerticalOrientation new
]

{ #category : #accessing }
ToTripletLayout >> cellSpacing [
	<return: #Number>
	
	^ cellSpacing
]

{ #category : #accessing }
ToTripletLayout >> cellSpacing: aNumber [	
	cellSpacing := aNumber asFloat
]

{ #category : #initialization }
ToTripletLayout >> defaultHorizontalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null horizontal
]

{ #category : #initialization }
ToTripletLayout >> defaultOrientation [
	"Return default orientation used by LinearLayout. If
	instance of my class is created with #new a horizontal orientation
	is used by defualt"
	<return: #ToTripletLayoutHorizontalOrientation>
	
	^ ToTripletLayoutHorizontalOrientation new
]

{ #category : #initialization }
ToTripletLayout >> defaultVerticalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment null vertical
]

{ #category : #initialization }
ToTripletLayout >> defaultWeightSum [
	"Default weight sum should be 0 to indicate that actual weight should be calculated
	as arithmetic sum of childrens' weight"
	<return: #Number>
	
	^ 0
]

{ #category : #'api - direction' }
ToTripletLayout >> direction [

	^ direction ifNil: [ self defaultDirection ]
]

{ #category : #'api - direction' }
ToTripletLayout >> direction: aBlLayoutDirection [

	direction := aBlLayoutDirection
]

{ #category : #accessing }
ToTripletLayout >> horizontalAlignment [
	^ horizontalAlignment
]

{ #category : #accessing }
ToTripletLayout >> horizontalAlignment: anAlignment [
	horizontalAlignment := anAlignment
]

{ #category : #initialization }
ToTripletLayout >> initialize [

	super initialize.

	weightSum := self defaultWeightSum.
	shouldUseLargestChild := false.
	cellSpacing := 0.0.
	interspace := 0.0.
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.

	self orientation: self defaultOrientation
]

{ #category : #accessing }
ToTripletLayout >> interspace [
	
	^ interspace
]

{ #category : #accessing }
ToTripletLayout >> interspace: aNumber [	
	
	interspace := aNumber asFloat
]

{ #category : #layout }
ToTripletLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	self orientation layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext.
	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext
]

{ #category : #'api - direction' }
ToTripletLayout >> leftToRight [

	self direction: BlLayoutDirection leftToRight
]

{ #category : #measure }
ToTripletLayout >> measure: anElement with: anExtentSpec [
	| aMeasurer |
	"I measure a new extent of myself and my children"
	
	aMeasurer := self newMeasurer.
	aMeasurer
		initializeWith: anElement
		layout: self
		extentSpec: anExtentSpec
		orientation: self orientation.
	
	aMeasurer measureOn: anElement.
	
	self
		measureIgnored: anElement
		with: (BlExtentMeasurementSpec exact: anElement measuredExtent)
]

{ #category : #measure }
ToTripletLayout >> newHorizontalMeasurer [ 

	^ ToTripletLayoutHorizontalMeasurer new 
]

{ #category : #measure }
ToTripletLayout >> newMeasurer [

	^ self orientation isHorizontal
		  ifTrue: [ self newHorizontalMeasurer ]
		  ifFalse: [ self newVerticalMeasurer ]
]

{ #category : #measure }
ToTripletLayout >> newVerticalMeasurer [ 

	^ ToTripletLayoutVerticalMeasurer new 
]

{ #category : #accessing }
ToTripletLayout >> orientation [
	^ orientation
]

{ #category : #accessing }
ToTripletLayout >> orientation: anOrientation [

	anOrientation layout: self.
	orientation := anOrientation.

]

{ #category : #'api - direction' }
ToTripletLayout >> rightToLeft [

	self direction: BlLayoutDirection rightToLeft
]

{ #category : #testing }
ToTripletLayout >> shouldUseLargestChild [
	"When true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally."
	<return: #Boolean>

	^ shouldUseLargestChild
]

{ #category : #accessing }
ToTripletLayout >> verticalAlignment [
	^ verticalAlignment
]

{ #category : #accessing }
ToTripletLayout >> verticalAlignment: anAlignment [
	verticalAlignment := anAlignment
]

{ #category : #accessing }
ToTripletLayout >> weightSum [
	<return: #Number>

	^ weightSum
]

{ #category : #accessing }
ToTripletLayout >> weightSum: aNumber [
	weightSum := aNumber asFloat
]

{ #category : #'api - configuration' }
ToTripletLayout >> withSpaceEqualization [
	"When set to true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally.
	Disabled by default."

	shouldUseLargestChild := true
]

{ #category : #'api - configuration' }
ToTripletLayout >> withoutSpaceEqualization [
	"When set to true, all children with a weight will be considered having the minimum size of the largest child.
	If false, all children are measured normally.
	Disabled by default."

	shouldUseLargestChild := false
]
