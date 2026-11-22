"
I check how `ToImage` converts its sources (a `Form`, an SVG string, an element, nil), how it answers the inner form or SVG element, how it recolors them, how it handles the `allowFormColorChange` setting, that a click on its picture targets the image itself, and that `fromUrl:` shows a pending icon while it loads.

I save the `allowFormColorChange` setting in `setUp` and restore it in `tearDown`, since some tests change it. The `tests - errors` protocol holds the cases that raise `NotFound`.
"
Class {
	#name : #ToImageTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'previousAllowFormColorChange'
	],
	#category : #'Toplo-Widget-Image-Tests'
}

{ #category : #helpers }
ToImageTest >> form [

	^ self iconNamed: #delete
]

{ #category : #helpers }
ToImageTest >> leafBackgroundsOf: anElement [
	"The backgrounds of the leaves of anElement, where the SVG converter puts the colors."

	| backgrounds |
	backgrounds := OrderedCollection new.
	anElement withAllChildrenDepthFirstDo: [ :child | child hasChildren ifFalse: [ backgrounds add: child background ] ].
	^ backgrounds
]

{ #category : #running }
ToImageTest >> setUp [

	super setUp.
	previousAllowFormColorChange := ToImage allowFormColorChange
]

{ #category : #helpers }
ToImageTest >> svgSource [

	^ ToMiscellaneousIcons filled_pending_work
]

{ #category : #running }
ToImageTest >> tearDown [

	ToImage allowFormColorChange: previousAllowFormColorChange.
	super tearDown
]

{ #category : #tests }
ToImageTest >> testAdaptToColorColorsSvgWhenFormColorChangeIsNotAllowed [

	| image |
	ToImage allowFormColorChange: false.
	image := ToImage inner: self svgSource.
	image adaptToColor: Color red.
	self assert: ((self leafBackgroundsOf: image innerSvgImage) allSatisfy: [ :each | each paint color = Color red ])
]

{ #category : #tests }
ToImageTest >> testAdaptToColorKeepsFormWhenFormColorChangeIsNotAllowed [

	| image form |
	ToImage allowFormColorChange: false.
	form := self form.
	image := ToImage inner: form.
	image adaptToColor: Color red.
	self assert: image innerFormImage identicalTo: form
]

{ #category : #tests }
ToImageTest >> testAdaptToColorRecolorsFormWhenFormColorChangeIsAllowed [

	| image |
	ToImage allowFormColorChange: true.
	image := ToImage inner: self form.
	image adaptToColor: Color red.
	self assert: (image innerFormImage colorAt: 8 @ 8) equals: Color red
]

{ #category : #tests }
ToImageTest >> testClickOnInnerImageTargetsTheImage [

	| image target |
	image := ToImage inner: self form.
	target := nil.
	image addEventHandlerOn: BlClickEvent do: [ :event | target := event target ].
	space deferAndSettle: [ space root addChild: image ].
	image innerImage eventSimulator click.
	space settle.
	self assert: target identicalTo: image
]

{ #category : #tests }
ToImageTest >> testEmptyImage [

	| image |
	image := ToImage new.
	self assert: (image innerImage isKindOf: BlElement).
	self deny: image hasInnerImage.
	self assert: image sourceImage isNil.
	self assert: image innerFormImage isNil.
	self assert: image innerSvgImage isNil
]

{ #category : #tests }
ToImageTest >> testEmptyImageHasNoExtent [

	| image |
	image := ToImage new.
	space deferAndSettle: [ space root addChild: image ].
	self assert: image extent equals: 0 @ 0
]

{ #category : #tests }
ToImageTest >> testImageWithElementReplacesItsId [

	| element |
	element := BlElement new
		           id: #mine;
		           yourself.
	ToImage inner: element.
	self assert: element id asSymbol equals: ToImage unknownInnerImageId
]

{ #category : #tests }
ToImageTest >> testImageWithElementUsesTheElement [

	| element image |
	element := BlElement new
		           extent: 10 @ 10;
		           yourself.
	image := ToImage inner: element.
	self assert: image innerImage identicalTo: element.
	self assert: element parent identicalTo: image.
	self assert: image innerFormImage isNil.
	self assert: image innerSvgImage isNil
]

{ #category : #tests }
ToImageTest >> testImageWithForm [

	| form image |
	form := self form.
	image := ToImage inner: form.
	self assert: image hasInnerImage.
	self assert: image sourceImage identicalTo: form.
	self assert: image innerImage id asSymbol equals: ToImage formInnerImageId.
	self assert: (image innerImage background isKindOf: BlImageBackground).
	self assert: image innerFormImage equals: form.
	self assert: image innerSvgImage isNil
]

{ #category : #tests }
ToImageTest >> testImageWithFormHasFormExtent [

	| form image |
	form := self form.
	image := ToImage inner: form.
	space deferAndSettle: [ space root addChild: image ].
	self assert: image extent equals: form extent
]

{ #category : #tests }
ToImageTest >> testImageWithSvgString [

	| svg image |
	svg := self svgSource.
	image := ToImage inner: svg.
	self assert: image hasInnerImage.
	self assert: image sourceImage identicalTo: svg.
	self assert: image innerImage id asSymbol equals: ToImage svgInnerImageId.
	self assert: image innerSvgImage identicalTo: image innerImage.
	self assert: image innerFormImage isNil
]

{ #category : #tests }
ToImageTest >> testImageWithSvgStringFillsTheImageExtent [

	| image |
	image := ToImage inner: self svgSource.
	image extent: 32 @ 32.
	space deferAndSettle: [ space root addChild: image ].
	self assert: image innerImage extent equals: 32 @ 32
]

{ #category : #tests }
ToImageTest >> testInnerImageColorColorsSvgLeaves [

	| image backgrounds |
	image := ToImage inner: self svgSource.
	image innerImageColor: Color red.
	backgrounds := self leafBackgroundsOf: image innerSvgImage.
	self denyEmpty: backgrounds.
	self assert: (backgrounds allSatisfy: [ :each | each paint color = Color red ])
]

{ #category : #tests }
ToImageTest >> testInnerImageColorRecolorsFormAndKeepsAlpha [

	| form image recolored |
	form := self form.
	image := ToImage inner: form.
	image innerImageColor: Color red.
	recolored := image innerFormImage.
	self deny: recolored identicalTo: form.
	self assert: recolored extent equals: form extent.
	self assert: (recolored colorAt: 8 @ 8) equals: Color red.
	self assert: (recolored colorAt: 0 @ 0) alpha equals: (form colorAt: 0 @ 0) alpha
]

{ #category : #tests }
ToImageTest >> testSettingANewSourceReplacesTheInnerImage [

	| image |
	image := ToImage inner: self form.
	image innerImage: self svgSource.
	self assert: image childrenCount equals: 1.
	self assert: image firstChild identicalTo: image innerImage.
	self assert: image innerSvgImage isNotNil
]

{ #category : #tests }
ToImageTest >> testSettingNilSourceEmptiesTheImage [

	| image |
	image := ToImage inner: self form.
	image innerImage: nil.
	self deny: image hasInnerImage.
	self assert: image sourceImage isNil.
	self assert: image childrenCount equals: 1
]

{ #category : #tests }
ToImageTest >> testSettingTheSameSourceKeepsTheInnerImage [

	| form image innerImage |
	form := self form.
	image := ToImage inner: form.
	innerImage := image innerImage.
	image innerImage: form.
	self assert: image innerImage identicalTo: innerImage
]

{ #category : #tests }
ToImageTest >> testWithInnerFormDoIfNoneOnEmptyImageEvaluatesNoneBlock [

	| formFound noneEvaluated |
	formFound := false.
	noneEvaluated := false.
	ToImage new withInnerFormDo: [ :form | formFound := true ] ifNone: [ noneEvaluated := true ].
	self deny: formFound.
	self assert: noneEvaluated
]

{ #category : #tests }
ToImageTest >> testWithInnerFormDoIfNoneOnFormImageEvaluatesBlock [

	| form found noneEvaluated |
	form := self form.
	found := nil.
	noneEvaluated := false.
	(ToImage inner: form) withInnerFormDo: [ :each | found := each ] ifNone: [ noneEvaluated := true ].
	self assert: found equals: form.
	self deny: noneEvaluated
]

{ #category : #'tests - errors' }
ToImageTest >> testWithInnerFormDoOnEmptyImageRaisesNotFound [

	self should: [ ToImage new withInnerFormDo: [ :form |  ] ] raise: NotFound
]

{ #category : #tests }
ToImageTest >> testWithInnerFormDoOnFormImageEvaluatesBlockWithForm [

	| form found |
	form := self form.
	found := nil.
	(ToImage inner: form) withInnerFormDo: [ :each | found := each ].
	self assert: found equals: form
]

{ #category : #'tests - errors' }
ToImageTest >> testWithInnerSvgElementDoOnFormImageRaisesNotFound [

	self should: [ (ToImage inner: self form) withInnerSvgElementDo: [ :element |  ] ] raise: NotFound
]

{ #category : #tests }
ToImageTest >> testWithInnerSvgElementDoOnSvgImageEvaluatesBlock [

	| image found |
	image := ToImage inner: self svgSource.
	found := nil.
	image withInnerSvgElementDo: [ :each | found := each ].
	self assert: found identicalTo: image innerImage
]
