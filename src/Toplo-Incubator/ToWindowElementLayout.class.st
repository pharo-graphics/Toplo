Class {
	#name : #ToWindowElementLayout,
	#superclass : #BlFrameLayout,
	#instVars : [
		'wspace'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToWindowElementLayout class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
ToWindowElementLayout class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #layout }
ToWindowElementLayout >> layout: aParentNode [

	super layout: aParentNode.
	aParentNode constraints position: 0@0.
	"self measuredBounds position: 0@0."
	'layout: ' trace. aParentNode position trace. ' ' trace. aParentNode extent traceCr.
]

{ #category : #layout }
ToWindowElementLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	| aParentNode |
	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext.
	
	aParentNode := anElement userData
		at: #layoutNode
		ifAbsent: [ ^ self ].
	
	anElement wspace position: aRectangle origin.
	aParentNode position: 0@0.
	aParentNode extent: aRectangle extent.
	self layout: aParentNode.

	aParentNode children do: [ :eachChildNode |
		eachChildNode element applyLayoutIn: eachChildNode layoutBounds context: aBlElementBoundsUpdateContext ].
]

{ #category : #layout }
ToWindowElementLayout >> measure: aParentNode [

	super measure: aParentNode.
	"'measure: ' trace. aParentNode position trace. ' ' trace. aParentNode extent traceCr."
]

{ #category : #accessing }
ToWindowElementLayout >> wspace [

	^ wspace
]

{ #category : #accessing }
ToWindowElementLayout >> wspace: aBlSpace [

	wspace := aBlSpace
]
