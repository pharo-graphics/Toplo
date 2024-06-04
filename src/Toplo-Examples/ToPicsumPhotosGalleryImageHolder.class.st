Class {
	#name : #ToPicsumPhotosGalleryImageHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'loader'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToPicsumPhotosGalleryImageHolder >> bindDataItem: aImageData [

	super bindDataItem: aImageData.
	aImageData loadedForm ifNil: [ ^ self ].
	self node background: (BlBackground image: aImageData loadedForm)
	
]

{ #category : #loading }
ToPicsumPhotosGalleryImageHolder >> loadImage [

	| form |
	self terminateLoader.
	form := self dataItem loadedForm.
	(form notNil and: [
		 form extent = self node measuredExtent asIntegerPoint ]) ifTrue: [
		^ self ].

	loader := [
	          | timesRetry byteArray |
	          timesRetry := 0.
	          [
	          (byteArray := [
	                        self urlStringFromNodeSize asUrl
		                        retrieveContents ]
		                        on: Error
		                        do: [  ]) isNil and: [ timesRetry < 5 ] ]
		          whileTrue: [ timesRetry := timesRetry + 1 ].
	          loader := nil.
	          byteArray ifNotNil: [
		          form := Form fromBinaryStream: byteArray readStream.
		          self dataItem loadedForm: form.
		          self node background: (BlBackground image: form) ] ]
		          newProcess.
	loader priority: Processor systemBackgroundPriority.
	loader name: 'ToPicsum.photo Gallery element loader'.
	loader resume
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageHolder >> release [ 

	self terminateLoader.
	super release
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageHolder >> terminateLoader [

	loader ifNotNil: #terminate.
	loader := nil
]

{ #category : #accessing }
ToPicsumPhotosGalleryImageHolder >> urlStringFromNodeSize [

	| s |
	s := self node size asIntegerPoint.
	^ 'https://unsplash.it/' , (s x min: 4096) asString , '/'
	  , (s y min: 4096) asString , '?image=' , self dataItem id asString
]
