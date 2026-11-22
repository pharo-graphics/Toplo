"
I check that `ToIcon` holds a `ToImage` that fills it, that I can create it with its image source, and that it forwards the source and the color to that image.
"
Class {
	#name : #ToIconTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Image-Tests'
}

{ #category : #helpers }
ToIconTest >> svgSource [

	^ ToMiscellaneousIcons filled_pending_work
]

{ #category : #tests }
ToIconTest >> testIconImageSetsTheInnerImage [

	| svg icon |
	svg := self svgSource.
	icon := ToIcon new.
	icon iconImage: svg.
	self assert: icon image sourceImage identicalTo: svg
]

{ #category : #tests }
ToIconTest >> testImageFillsTheIcon [

	| constraints |
	constraints := ToIcon new image constraints.
	self assert: constraints horizontal resizer isMatchParent.
	self assert: constraints vertical resizer isMatchParent
]

{ #category : #tests }
ToIconTest >> testImageReplacesThePreviousImage [

	| icon previous next |
	icon := ToIcon new.
	previous := icon image.
	next := ToImage inner: self svgSource.
	icon image: next.
	self assert: icon image identicalTo: next.
	self assert: previous parent isNil.
	self assert: icon childrenCount equals: 1
]

{ #category : #tests }
ToIconTest >> testInnerImageColorIsForwardedToTheImage [

	| icon leaves |
	icon := ToIcon innerImage: self svgSource.
	icon innerImageColor: Color red.
	leaves := OrderedCollection new.
	icon image innerSvgImage withAllChildrenDepthFirstDo: [ :child | child hasChildren ifFalse: [ leaves add: child background ] ].
	self denyEmpty: leaves.
	self assert: (leaves allSatisfy: [ :each | each paint color = Color red ])
]

{ #category : #tests }
ToIconTest >> testInnerImageCreatesIconShowingTheSource [

	| svg icon |
	svg := self svgSource.
	icon := ToIcon innerImage: svg.
	self assert: icon image sourceImage identicalTo: svg.
	self assert: icon innerImage identicalTo: icon image innerImage
]

{ #category : #tests }
ToIconTest >> testNewIconHoldsAnEmptyImage [

	| icon |
	icon := ToIcon new.
	self assert: (icon image isKindOf: ToImage).
	self assert: icon image parent identicalTo: icon.
	self deny: icon image hasInnerImage
]
