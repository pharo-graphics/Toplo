"
I'm part of the Photo gallery example. I'm not expected to be used as a standalone.
"
Class {
	#name : #ToExPicsumHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'loader'
	],
	#category : #'Toplo-Examples-PhotoGalleryParts'
}

{ #category : #accessing }
ToExPicsumHolder >> bindDataItem: aImageData [

	super bindDataItem: aImageData.
	self node labelString: aImageData id.
	aImageData loadedForm ifNil: [ ^ self ].
	self node background: (BlBackground image: aImageData loadedForm).

]

{ #category : #loading }
ToExPicsumHolder >> loadImage [

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
ToExPicsumHolder >> terminateLoader [

	loader ifNotNil: #terminate.
	loader := nil
]

{ #category : #accessing }
ToExPicsumHolder >> unbindDataItem [

	self terminateLoader.
	super unbindDataItem 
	
]

{ #category : #accessing }
ToExPicsumHolder >> urlStringFromNodeSize [

	| s |
	s := self node extent asIntegerPoint.
	^ 'https://unsplash.it/' , (s x min: 4096) asString , '/'
	  , (s y min: 4096) asString , '?image=' , self dataItem id asString
]
