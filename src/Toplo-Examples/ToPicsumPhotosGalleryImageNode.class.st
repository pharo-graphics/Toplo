Class {
	#name : #ToPicsumPhotosGalleryImageNode,
	#superclass : #ToListNode,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Examples'
}

{ #category : #initialization }
ToPicsumPhotosGalleryImageNode >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageNode >> defaultWidth [

	^ 500
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageNode >> initialize [

	super initialize.
	label := ToLabel new
		         hFitContent;
		         yourself.
	label background: Color black.
	label withNullSkin.
	self addChild: label
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageNode >> labelString: aString [

	label text: (aString asRopedText
			 foreground: Color white;
			 fontSize: 14)
]

{ #category : #layout }
ToPicsumPhotosGalleryImageNode >> onMeasure: anExtentMeasurementSpec [

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
