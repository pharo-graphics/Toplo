Class {
	#name : #ToExShapeContainerElement,
	#superclass : #BlElement,
	#instVars : [
		'shapes'
	],
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #'instance creation' }
ToExShapeContainerElement class >> open [

	<script>
	self new openInSpace
]

{ #category : #drawing }
ToExShapeContainerElement >> aeDrawOn: aeCanvas [

	| extent |
	super aeDrawOn: aeCanvas.
	extent := self extent.
	shapes do: [ :s |
		aeCanvas pathFactory: [ :cairoContext |
			cairoContext
				circleCenterX: s shape center x * extent x / 100
				y: s shape center y * extent y / 100
				radius: s shape radius ].
		aeCanvas setBackgroundWith: [ aeCanvas setSourceColor: s background ].
		aeCanvas drawFigure ]
]

{ #category : #initialization }
ToExShapeContainerElement >> initialize [

	super initialize.
	shapes := [  ].
	self background: Color veryLightGray.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
ToExShapeContainerElement >> shapes [

	^ shapes 
]

{ #category : #accessing }
ToExShapeContainerElement >> shapes: aShapeModelArray [

	shapes := aShapeModelArray.
	self invalidate
]
