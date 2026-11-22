"
I am a Toplo element that shows an image. I take an image source (a `Form`, an SVG document as a string, or any object that answers an element to `asElement`) and convert it into an inner element that I display centered. I give Toplo one kind of element for icons and pictures, whatever their source, that skins can recolor and widgets can lay out like any other element.

`inner:` creates me with a source and `innerImage:` changes it; `sourceImage` answers the source and `innerImage` the element built from it. `innerImageColor:` recolors me and `adaptToColor:` lets a skin recolor me when the setting allows it.

## Examples

```
ToImage exampleForm.
ToImage exampleSvg.
ToImage exampleColoredSvg.
ToImage scriptImageSources.
```

## Design Rationale

- I keep the source and the inner element apart. The source is what clients gave and can give again (`sourceImage`), for example to build a new image from the same source instead of moving me to another parent. The inner element is a private conversion: a `Form` becomes an element with a `BlImageBackground`, an SVG string becomes the element built by `BlSvgConverter`, and any other object becomes `asElement`. I tag the inner element with an id (`ToImage class>>formInnerImageId`, `svgInnerImageId`, `unknownInnerImageId`) so that `innerFormImage` and `innerSvgImage` know what they hold.
- Setting the same source again does nothing, so skins and widgets can send `innerImage:` on each update without rebuilding the element.
- Recoloring depends on the kind of source. An SVG image colors its leaf elements. A form is replaced by a copy with the new color and the alpha of the original, so its shape stays. Skins send `adaptToColor:` when the foreground changes (hovered, pressed, disabled); it recolors SVG images but leaves forms alone unless the `allowFormColorChange` setting (Toplo settings, off by default) is on, since most forms are colored pictures rather than glyphs.
- I prevent mouse events on my children, so that a click on the picture targets me: widgets that contain me (buttons, menu items) see me as a leaf.
- `fromUrl:` loads a remote image in a background process. It shows a pending icon at once, tries up to five times, and shows a close icon if it fails. `terminateLoader` stops the loading.

## Usage

1. Icon providers create me: `ToLocationIconProvider>>iconNamed:ifAbsent:` and `ToImportedIconProvider class>>iconNamed:ifAbsent:` answer me wrapping their icon. Widgets wrap a raw source in me: `ToButton>>iconImage:` and `TToLabeledIcon>>iconImage:` send `ToImage inner:` when they do not get a `ToImage`. `TToImageHolder>>initializeAsImageHolder` gives each `ToIcon` an empty one.
2. My container keeps me as a child. Skins recolor me: `ToButtonSkin` and `ToMenuItemSkin` send `adaptToColor:`, `ToCheckboxSkin` sends `innerImageColor:`.

I am mutable: `innerImage:` replaces my child, and colors replace or change the inner element. Like any element, use me from the UI process.

## Implementation Notes

- A form gives me its extent, but an SVG inner element matches its parent while I fit my content: give me an extent (`extent: 32 @ 32`) when I show an SVG image, or I have none.
- An element given as a source is used as my child, not copied, and its id is replaced by `#unknown`.
- Recoloring a form goes through `innerImage:`, so `sourceImage` then answers the recolored copy and the original form is lost. This is a known issue.
- `innerForm` and `formColor:` are deprecated: use `innerFormImage` and `innerImageColor:`.
"
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

{ #category : #examples }
ToImage class >> exampleColoredSvg [

	<sampleInstance>
	^ self exampleSvg
		  innerImageColor: Color red;
		  yourself
]

{ #category : #examples }
ToImage class >> exampleForm [

	<sampleInstance>
	^ self inner: (self iconNamed: #delete)
]

{ #category : #examples }
ToImage class >> exampleSvg [

	<sampleInstance>
	^ (self inner: ToMiscellaneousIcons filled_pending_work)
		  extent: 32 @ 32;
		  yourself
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

{ #category : #script }
ToImage class >> scriptImageSources [
	"The sources a ToImage accepts, side by side: a Form, an SVG string, the same SVG colored in red, a rotated Form, and a plain Bloc element."

	<example>
	| pane rotated element |
	pane := ToPane new.
	pane layout: (BlLinearLayout horizontal cellSpacing: 20).
	pane fitContent.
	pane padding: (BlInsets all: 20).
	rotated := self exampleForm.
	rotated rotateBy: 45.
	element := BlElement new
		           extent: 16 @ 16;
		           background: Color orange;
		           yourself.
	pane addChildren: {
		self exampleForm.
		self exampleSvg.
		self exampleColoredSvg.
		rotated.
		(self inner: element) }.
	pane openInSpace.
	^ pane
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
			id asSymbol = self svgInnerImageId ifTrue: [
					innerImage matchParent.
					innerImage withAllChildrenBreadthFirstDo: [ :child |
						child clipChildren: false.
						child constraints ignoreByLayout ] ] ]
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
ToImage >> sourceImage [

	^ sourceImage
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
