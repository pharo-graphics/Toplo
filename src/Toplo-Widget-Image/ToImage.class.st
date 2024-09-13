Class {
	#name : #ToImage,
	#superclass : #ToElement,
	#instVars : [
		'innerImage'
	],
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #accessing }
ToImage class >> formInnerImageId [

	^ #form
]

{ #category : #'instance creation' }
ToImage class >> inner: anImage [

	^ self new innerImage: anImage
]

{ #category : #accessing }
ToImage class >> svgInnerImageId [

	^ #svgPath 
]

{ #category : #accessing }
ToImage class >> unknownInnerImageId [

	^ #unknown
]

{ #category : #'private - conversion' }
ToImage >> convertedAsInnerImage: aSource [

	^ aSource isString
		  ifTrue: [
			  (BlSvgConverter convertFromString: aSource)
				  id: self svgInnerImageId;
				  yourself ]
		  ifFalse: [
			  aSource asElement id: (aSource isForm
					   ifTrue: [ self formInnerImageId ]
					   ifFalse: [ self unknownInnerImageId ]) ]
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
ToImage >> errorInnerSvgElementNotFound [
	"Raise a NotFound exception."

	NotFound signalFor: self
]

{ #category : #accessing }
ToImage >> formInnerImageId [

	^ self class formInnerImageId
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
ToImage >> innerFormImage [
	"Convenience method that returns nil if the request makes no sense or if there is no form."

	^ self innerImage background formImage
]

{ #category : #'form accessing' }
ToImage >> innerFormImageColor: aColor [

	self
		withInnerFormDo: [ :form |
			self innerImage:
				(form collectColors: [ :color | aColor alpha: color alpha ]) ]
		ifNone: [  ]
]

{ #category : #accessing }
ToImage >> innerImage [

	^ innerImage
]

{ #category : #accessing }
ToImage >> innerImage: anImage [

	| element |
	anImage = innerImage ifTrue: [ ^ self ].
	element := anImage ifNil: [ self defaultInnerImage ].
	element := self convertedAsInnerImage: element.
	self removeChildren.
	innerImage := element.
	self addChild: element.
	element id ifNotNil: [ :id |
		id asSymbol = self svgInnerImageId ifTrue: [
			element constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ] ] ]
]

{ #category : #'form accessing' }
ToImage >> innerImageColor: aColor [

	self innerSvgImage ifNotNil: [ ^ self innerSvgImageColor: aColor ].
	self innerFormImage ifNotNil: [ ^ self innerFormImageColor: aColor ]
]

{ #category : #'form accessing' }
ToImage >> innerSvgImage [
	"Convenience method that returns nil if the request makes no sense or if there is no svg image."

	^ self innerImage id = self svgInnerImageId
		  ifTrue: [ self innerImage ]
		  ifFalse: [  ]
]

{ #category : #'form accessing' }
ToImage >> innerSvgImageColor: aColor [

	self
		withInnerSvgElementDo: [ :e |
			e withAllChildrenDepthFirstDo: [ :child |
				child hasChildren ifFalse: [ child background: aColor ] ] ]
		ifNone: [  ]
]

{ #category : #rotation }
ToImage >> rotateBy: aDegreesAngle [

	self innerImage
		constraintsDo: [ :c | c accountTransformation ];
		transformDo: [ :t | t rotateBy: aDegreesAngle ]
]

{ #category : #accessing }
ToImage >> svgInnerImageId [

	^ self class svgInnerImageId
]

{ #category : #accessing }
ToImage >> unknownInnerImageId [

	^ self class unknownInnerImageId
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

	self innerFormImage
		ifNil: [ aNoneBlock value ]
		ifNotNil: [ :f | aBlock value: f ]
]

{ #category : #'form accessing' }
ToImage >> withInnerSvgElementDo: aBlock [
	" aBlock is evaluated with the svg element as arguments 
	if the result of #innerForm is not nil "

	self
		withInnerSvgElementDo: aBlock
		ifNone: [ self errorInnerSvgElementNotFound ]
]

{ #category : #'form accessing' }
ToImage >> withInnerSvgElementDo: aBlock ifNone: aNoneBlock [
	" aBlock is evaluated with the svg element as arguments 
	if the result of #innerSvgImage is not nil, else, aNoneBlock is evaluated "

	self innerSvgImage
		ifNil: [ aNoneBlock value ]
		ifNotNil: [ :f | aBlock value: f ]
]
