Class {
	#name : #ToPicsumPhotosGalleryImageElement,
	#superclass : #ToNode,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Examples'
}

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultWidth [

	^ 500
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> initialize [

	super initialize.
	label := ToLabel new
		         hFitContent;
		         yourself.
	label background: Color black.
	label withNullSkin.
	self addChild: label
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> labelString: aString [

	label text: (aString asRopedText
			 foreground: Color white;
			 fontSize: 14)
]

{ #category : #layout }
ToPicsumPhotosGalleryImageElement >> onMeasure: anExtentMeasurementSpec [

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
