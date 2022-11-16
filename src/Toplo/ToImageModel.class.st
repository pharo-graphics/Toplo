Class {
	#name : #ToImageModel,
	#superclass : #ToViewModel,
	#category : #'Toplo-Widget-Images'
}

{ #category : #accessing }
ToImageModel >> innerImage: anImage [

	self widgetDo: [ :widget | widget innerImage: anImage]
]

{ #category : #'private - accessing - widget' }
ToImageModel >> privateWidgetClass [

	^ ToImage
]

{ #category : #'api - change hook' }
ToImageModel >> whenInnerImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self widgetDo: [ :widget | widget whenInnerImageReplacedDo: aBlock ]
]
