Class {
	#name : #ToImageModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#image => ObservableSlot'
	],
	#category : #'Toplo-Widget-Images'
}

{ #category : #initialization }
ToImageModel >> defaultImage [

	^ BlElement new
		  size: 0 @ 0;
		  background: Color blue;
		  yourself
]

{ #category : #accessing }
ToImageModel >> image [

	^ image
]

{ #category : #accessing }
ToImageModel >> image: anImageElement [

	image = anImageElement ifTrue: [ ^ self ].
	self widgetDo: [ :widget | image := anImageElement ifNotNil: [:im | im asElement ] ]
]

{ #category : #initialization }
ToImageModel >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	

]

{ #category : #'api - hooks' }
ToImageModel >> onInstalledOnlyMeIn: anElement [

	super onInstalledOnlyMeIn: anElement.
	self whenImageReplacedDo: [ :t | anElement privateImage: t ].
	self image: self defaultImage. 


]

{ #category : #'private - accessing - widget' }
ToImageModel >> privateWidgetClass [

	^ ToImage
]

{ #category : #'api - change hook' }
ToImageModel >> whenImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #image whenChangedDo: aBlock
]
