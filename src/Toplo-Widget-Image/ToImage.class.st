Class {
	#name : #ToImage,
	#superclass : #ToElement,
	#instVars : [
		'innerImage'
	],
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #'instance creation' }
ToImage class >> inner: anImage [
	^ self new innerImage: anImage
]

{ #category : #'instance creation' }
ToImage class >> svgPathString: aString [

	^ self inner: ((BlSvgConverter convertFromString: aString) id: #svgPath; yourself)
]

{ #category : #initialization }
ToImage >> defaultInnerImage [

	^ BlElement new
		  id: #emptyImage;
		  size: 0 @ 0;
		  yourself
]

{ #category : #initialization }
ToImage >> defaultLayout [ 

	^ BlFrameLayout new
]

{ #category : #'form accessing' }
ToImage >> errorInnerFormNotFound [
	"Raise a NotFound exception."

	NotFound signalFor: self
]

{ #category : #'form accessing' }
ToImage >> formColor: aColor [

	self
		withInnerFormDo: [ :form |
			self innerImage:
				(form collectColors: [ :color | aColor alpha: color alpha ]) ]
		ifNone: [  ]
]

{ #category : #testing }
ToImage >> hasInnerImage [

	^ self innerImage id asSymbol ~= #emptyImage
]

{ #category : #initialization }
ToImage >> initialize [

	super initialize.
	self fitContent.
	innerImage := self defaultInnerImage.
	self addChild: innerImage.
	" I ** must be ** considered as a leaf of a UI element tree. Otherwise, click may not work on me. This is why my children are not allowed to manage mouse events. Related to https://github.com/plantec/Toplo/issues/41"
	self preventChildrenMouseEvents
]

{ #category : #'form accessing' }
ToImage >> innerForm [
	"Convenience method that returns nil if the request makes no sense or if there is no form."

	^ self innerImage background formImage
]

{ #category : #accessing }
ToImage >> innerImage [

	^ innerImage
]

{ #category : #accessing }
ToImage >> innerImage: anImage [

	| element |
	element := anImage
		           ifNil: [ self defaultInnerImage ]
		           ifNotNil: [ anImage asElement ].
	anImage = innerImage ifTrue: [ ^ self ].
	self removeChildren.
	innerImage := element.
	self addChild: element.
	element id asSymbol = #svgPath ifTrue: [
		element constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ] ].
	self requestNewSkin
]

{ #category : #rotation }
ToImage >> rotateBy: aDegreesAngle [

	self innerImage
		constraintsDo: [ :c | c accountTransformation ];
		transformDo: [ :t | t rotateBy: aDegreesAngle ]
]

{ #category : #'form accessing' }
ToImage >> withInnerFormDo: aBlock [
	" aBlock is evaluated with the form as arguments 
	if the result of #innerForm is not nil "

	self withInnerFormDo: aBlock ifNone: [ self errorInnerFormNotFound ]
]

{ #category : #'form accessing' }
ToImage >> withInnerFormDo: aBlock ifNone: aNoneBlock [
	" aBlock is evaluated with the form as arguments 
	if the result of #innerForm is not nil, else, aNoneBlock is evaluated "

	self innerForm ifNil: aNoneBlock ifNotNil: [ :f | aBlock value: f ]
]
