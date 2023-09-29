Class {
	#name : #ToPicsumPhotosGalleryImageElement,
	#superclass : #ToElement,
	#traits : 'TToNode',
	#classTraits : 'TToNode classTrait',
	#instVars : [
		'loader',
		'imageData',
		'label'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> attached [

	imageData form ifNil: [ ^ self loadImage ].
	self setBackgroundFromData
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultEventHandler [ 

	^ ToNodeEventHandler new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> defaultWidth [
	^ 500
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> detached [

	loader ifNotNil: #terminate.
	loader := nil
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> form: aForm [
	
	imageData form == aForm
		ifTrue: [ ^ self ].
	imageData form: aForm.
	self setBackgroundFromData
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> imageData: anImageData [

	imageData = anImageData
		ifTrue: [ ^ self ].
	imageData := anImageData.
	label text: ((anImageData id asString) asRopedText
		foreground: Color white;
		fontSize: 14)
]

{ #category : #initialization }
ToPicsumPhotosGalleryImageElement >> initialize [

	super initialize.
	self initializeListNode.
	label := ToLabel new
		         hFitContent;
		         yourself.
	label background: Color black.
	label withSkin: nil.
	self addChild: label.
	self whenLayoutedDo: [ self loadImage ]
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> loadImage [

	loader ifNotNil: [ ^ self ].
	(imageData form isNotNil and: [ imageData form extent = self extent asIntegerPoint ]) ifTrue: [	^ self ].

	loader := [
	          | newForm timesRetry byteArray |
	          timesRetry := 0.
	          [
	          (byteArray := [
	                         (imageData loadUrl: self extent asIntegerPoint) asUrl retrieveContents ]
		                         on: Error
		                         do: [  ]) isNil and: [ timesRetry < 5 ] ]
		          whileTrue: [ timesRetry := timesRetry + 1 ].
	          byteArray ifNotNil: [
		          newForm := Form fromBinaryStream: byteArray readStream.
		          self enqueueTask: (BlTaskAction new action: [ self loadedForm: newForm ]) ] ] newProcess.
	loader priority: Processor systemBackgroundPriority.
	loader name: 'ToPicsum.photo Gallery element loader'.
	loader resume
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> loadedForm: aForm [
	
	self form: aForm.
	loader := nil
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

	self measuredExtent: aWidth @ aHeight
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageElement >> setBackgroundFromData [
	
	self background: (BlBackground image: imageData form).
	self requestLayout.
	self invalidate
]
