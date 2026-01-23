Class {
	#name : #ToImage,
	#superclass : #ToElement,
	#instVars : [
		'innerImage',
		'loader',
		'innerImageColor',
		'sourceImage'
	],
	#classVars : [
		'AllowFormColorChange'
	],
	#category : #'Toplo-Widget-Image-Core'
}

{ #category : #testing }
ToImage class >> allowFormColorChange [

	^ AllowFormColorChange ifNil: [ AllowFormColorChange := false ]
]

{ #category : #testing }
ToImage class >> allowFormColorChange: aBoolean [

	AllowFormColorChange := aBoolean
]

{ #category : #accessing }
ToImage class >> formInnerImageId [

	^ #form
]

{ #category : #'instance creation' }
ToImage class >> fromUrl: anUrl [

	^ self new fromUrl: anUrl
]

{ #category : #'instance creation' }
ToImage class >> inner: anImage [

	^ self new innerImage: anImage
]

{ #category : #settings }
ToImage class >> settingsOn: aBuilder [

	<systemsettings>
	(aBuilder setting: #allowFormColorChange)
		parent: #Toplo;
		label: 'Enable Form color change in a ToImage';
		default: false;
		target: self;
		description: 'Allow/disallow form color change in a ToImage'
]

{ #category : #accessing }
ToImage class >> svgInnerImageId [

	^ #svgPath 
]

{ #category : #accessing }
ToImage class >> unknownInnerImageId [

	^ #unknown
]

{ #category : #'inner accessing' }
ToImage >> adaptToColor: aColor [

	self innerFormImage ifNotNil: [
		self allowFormColorChange ifFalse: [ ^ self ] ].
	self innerImageColor: aColor
]

{ #category : #testing }
ToImage >> allowFormColorChange [

	^ self class allowFormColorChange
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
		  extent: 0 @ 0;
		  yourself
]

{ #category : #'inner accessing' }
ToImage >> errorInnerFormNotFound [
	"Raise a NotFound exception."

	NotFound signalFor: self
]

{ #category : #'inner accessing' }
ToImage >> errorInnerSvgElementNotFound [
	"Raise a NotFound exception."

	NotFound signalFor: self
]

{ #category : #'inner accessing' }
ToImage >> formColor: aColor [

	self
		deprecated: 'Use #innerImageColor:'
		transformWith: '`@recvr formColor: `@aColor '
			-> '`@recvr innerImageColor: `@aColor'.
	self innerImageColor: aColor
]

{ #category : #accessing }
ToImage >> formInnerImageId [

	^ self class formInnerImageId
]

{ #category : #'private loading' }
ToImage >> fromUrl: anUrl [

	self terminateLoader.
	self innerImage: ToMiscellaneousIcons filled_pending_work.
	loader := [
	          | timesRetry contents |
	          timesRetry := 0.
	          [
	          (contents := [ anUrl asUrl retrieveContents ]
		                       on: Error
		                       do: [  ]) isNil and: [ timesRetry < 5 ] ]
		          whileTrue: [ timesRetry := timesRetry + 1 ].
	          contents
		          ifNil: [
		          self innerImage: ToMiscellaneousIcons round_close ]
		          ifNotNil: [
			          | source |
			          source := contents isString
				                    ifTrue: [ contents ]
				                    ifFalse: [
				                    Form fromBinaryStream: contents readStream ].
			          self innerImage: source ].
	          loader := nil ] newProcess.
	loader priority: Processor userBackgroundPriority.
	loader name: 'ToImage loader'.
	loader resume
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

{ #category : #'inner accessing' }
ToImage >> innerForm [
	"Convenience method that returns nil if the request makes no sense or if there is no form."

	self deprecated: 'Use #innerFormImage' transformWith: '`@recvr innerForm'->'`@recvr innerFormImage'.
	^ self innerFormImage
]

{ #category : #'inner accessing' }
ToImage >> innerFormImage [
	"Convenience method that returns nil if the request makes no sense or if there is no form."

	^ self innerImage background formImage
]

{ #category : #'inner accessing' }
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

	sourceImage = anImage ifTrue: [ ^ self ].
	sourceImage := anImage.
	innerImageColor := nil.
	innerImage := sourceImage
		              ifNotNil: [ :srcIm |
		              self convertedAsInnerImage: srcIm ]
		              ifNil: [ self defaultInnerImage ].
	self removeChildren.
	self addChild: innerImage.

	innerImage constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ].

	innerImage id ifNotNil: [ :id |
		id asSymbol = self svgInnerImageId ifTrue: [ innerImage matchParent ] ]
]

{ #category : #'inner accessing' }
ToImage >> innerImageColor: aColor [
	innerImageColor = aColor ifTrue: [ ^ self ].
	self innerSvgImage ifNotNil: [ self innerSvgImageColor: aColor ].
	self innerFormImage ifNotNil: [ self innerFormImageColor: aColor ].
	innerImageColor := aColor
]

{ #category : #accessing }
ToImage >> innerImageDo: aBlock [

	innerImage ifNil: [ ^ self ].
	aBlock value: innerImage
]

{ #category : #'inner accessing' }
ToImage >> innerSvgImage [
	"Convenience method that returns nil if the request makes no sense or if there is no svg image."

	^ self innerImage id = self svgInnerImageId
		  ifTrue: [ self innerImage ]
		  ifFalse: [  ]
]

{ #category : #'inner accessing' }
ToImage >> innerSvgImageColor: aColor [

	self
		withInnerSvgElementDo: [ :e |
			e withAllChildrenDepthFirstDo: [ :child |
				child hasChildren ifFalse: [ child background: aColor ] ] ]
		ifNone: [  ]
]

{ #category : #'private loading' }
ToImage >> isLoading [

	^ loader notNil
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

{ #category : #'private loading' }
ToImage >> terminateLoader [

	loader ifNotNil: #terminate.
	loader := nil
]

{ #category : #accessing }
ToImage >> unknownInnerImageId [

	^ self class unknownInnerImageId
]

{ #category : #'inner accessing' }
ToImage >> withInnerFormDo: aBlock [
	" aBlock is evaluated with the form as arguments
	if the result of #innerForm is not nil "

	self withInnerFormDo: aBlock ifNone: [ self errorInnerFormNotFound ]
]

{ #category : #'inner accessing' }
ToImage >> withInnerFormDo: aBlock ifNone: aNoneBlock [
	" aBlock is evaluated with the form as arguments 
	if the result of #innerForm is not nil, else, aNoneBlock is evaluated "

	self innerFormImage
		ifNil: [ aNoneBlock value ]
		ifNotNil: [ :f | aBlock value: f ]
]

{ #category : #'inner accessing' }
ToImage >> withInnerSvgElementDo: aBlock [
	" aBlock is evaluated with the svg element as arguments 
	if the result of #innerForm is not nil "

	self
		withInnerSvgElementDo: aBlock
		ifNone: [ self errorInnerSvgElementNotFound ]
]

{ #category : #'inner accessing' }
ToImage >> withInnerSvgElementDo: aBlock ifNone: aNoneBlock [
	" aBlock is evaluated with the svg element as arguments 
	if the result of #innerSvgImage is not nil, else, aNoneBlock is evaluated "

	self innerSvgImage
		ifNil: [ aNoneBlock value ]
		ifNotNil: [ :f | aBlock value: f ]
]
