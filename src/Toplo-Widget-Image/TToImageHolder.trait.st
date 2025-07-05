Trait {
	#name : #TToImageHolder,
	#instVars : [
		'image'
	],
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #'t - image holder - instance creation' }
TToImageHolder classSide >> innerImage: anImage [

	^ self new innerImage: anImage; yourself
]

{ #category : #'t - image holder - accessing' }
TToImageHolder >> image [ 

	^ image
]

{ #category : #'t - image holder - accessing' }
TToImageHolder >> image: anImage [

	image = anImage ifTrue: [ ^ self ].
	image ifNotNil: [ image removeFromParent ].
	image := anImage.
	image ifNotNil: [
			image matchParent.
			self addChild: image ]
]

{ #category : #'t - image holder - initialization' }
TToImageHolder >> initializeAsImageHolder [

	self image: ToImage new
]

{ #category : #'t - image holder - accessing' }
TToImageHolder >> innerImage [

	^ self image innerImage
]

{ #category : #'t - image holder - accessing' }
TToImageHolder >> innerImage: anElementOSvgPathStringOrForm [

	self image innerImage: anElementOSvgPathStringOrForm
]

{ #category : #'t - image holder - accessing' }
TToImageHolder >> innerImageColor: aColor [

	self image innerImageColor: aColor
]
