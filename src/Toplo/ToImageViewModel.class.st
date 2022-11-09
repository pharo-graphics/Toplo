Class {
	#name : #ToImageViewModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#image => ObservableSlot'
	],
	#category : #'Toplo-Widget-Images'
}

{ #category : #initialization }
ToImageViewModel >> defaultImage [

	^ BlElement new
		  size: 0 @ 0;
		  background: Color blue;
		  yourself
]

{ #category : #accessing }
ToImageViewModel >> image [

	^ image
]

{ #category : #accessing }
ToImageViewModel >> image: anImageElement [

	image = anImageElement ifTrue: [ ^ self ].
	self widgetPerformOrDefer: [ :widget | image := anImageElement ifNotNil: [:im | im asElement ] ]
]

{ #category : #initialization }
ToImageViewModel >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	

]

{ #category : #'api - change hook' }
ToImageViewModel >> onImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #image whenChangedDo: aBlock
]

{ #category : #'api - hooks' }
ToImageViewModel >> onInstalledOnlyMeIn: anElement [

	super onInstalledOnlyMeIn: anElement.
	self onImageReplacedDo: [ :t | anElement privateImage: t ].
	self image: self defaultImage. 


]

{ #category : #'private - accessing - widget' }
ToImageViewModel >> privateNewWidget [

	^ ToImage new
]
