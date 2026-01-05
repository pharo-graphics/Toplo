"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
See `ToSandBox class>>#example_PicsumPhotosGallery`
"
Class {
	#name : #ToExPicsumNode,
	#superclass : #ToBasicListNode,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #initialization }
ToExPicsumNode >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToExPicsumNode >> defaultWidth [

	^ 500
]

{ #category : #initialization }
ToExPicsumNode >> initialize [

	super initialize.
	label := ToLabel new
		         hFitContent;
		         yourself.
	label background: Color black.
	label withNullSkin.
	self addChild: label.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #accessing }
ToExPicsumNode >> labelString: aString [

	label text: (aString asRopedText
			 foreground: Color white;
			 fontSize: 14)
]

{ #category : #layout }
ToExPicsumNode >> onMeasure: anExtentMeasurementSpec [

	" ensure a 16/9 size "

	| aWidth aHeight aWidthSpec aHeightSpec |
	super onMeasure: anExtentMeasurementSpec.
	
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	aWidth := aWidthSpec isUnspecified
		ifTrue: [ self defaultWidth ]
		ifFalse: [ aWidthSpec size ].
	"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeight := aHeightSpec isUnspecified
		ifTrue: [ (aWidth / 16 * 9) ]
		ifFalse: [ aHeightSpec size ].

	self measuredExtent: aWidth @ aHeight.
	self holder loadImage

]
