Class {
	#name : #ToBasicCircularLayout,
	#superclass : #BlBasicLayout,
	#instVars : [
		'startAngle',
		'inset',
		'startAngleOffset'
	],
	#category : #'Toplo-Widget-Circular-BasicElement'
}

{ #category : #layout }
ToBasicCircularLayout >> angularDistanceToRightAxis: angle [
    | a |
    a := angle \\ (2 * Float pi).
    ^ a > Float pi
        ifTrue: [ 2 * Float pi - a ]
        ifFalse: [ a ]
]

{ #category : #layout }
ToBasicCircularLayout >> applyZIndexFrom: infos [

	| top |
	top := (infos sort: [ :a :b | a second < b second ]) first.

	infos do: [ :info |
			| el |
			el := info first.
			el zIndex: (info == top
					 ifTrue: [ 100 ]
					 ifFalse: [ 2 ]) ]
]

{ #category : #initialization }
ToBasicCircularLayout >> initialize [

	super initialize.
	startAngle := 0.
	startAngleOffset := 0.
	inset := 0.
]

{ #category : #accessing }
ToBasicCircularLayout >> inset [

	^ inset
]

{ #category : #accessing }
ToBasicCircularLayout >> inset: anObject [

	inset := anObject
]

{ #category : #layout }
ToBasicCircularLayout >> layout: anElement in: aBounds context: aBlElementBoundsUpdateContext [

	| n step center radiusX radiusY infos |
	super
		layout: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext.
	n := anElement children size.
	n = 0 ifTrue: [ ^ self ].

	center := anElement measuredExtent / 2.
	radiusX := anElement measuredExtent x / 2 - inset.
	radiusY := anElement measuredExtent y / 2 - inset.
	step := 2.0 * Float pi / n.

	infos := OrderedCollection new.

	anElement children asArray withIndexDo: [ :child :i |
			| angle pos offset width height mid distance |
			child userData at: #id ifAbsentPut: [ i ].
			angle := startAngle + startAngleOffset + (step * (i - 1)).
			mid := angle + (step / 2).
			pos := center + (radiusX * angle cos @ (radiusY * angle sin)).
			offset := child extent / 2.
			width := child measuredWidth.
			height := child measuredHeight.
			distance := self angularDistanceToRightAxis: mid.

			infos add: {
					child.
					distance }.
			child
				applyLayoutIn: (pos - offset extent: width @ height)
				context: aBlElementBoundsUpdateContext ].

	self applyZIndexFrom: infos
]

{ #category : #accessing }
ToBasicCircularLayout >> startAngle [

	^ startAngle
]

{ #category : #accessing }
ToBasicCircularLayout >> startAngle: aDegrees [

	startAngle := aDegrees
]

{ #category : #accessing }
ToBasicCircularLayout >> startAngleOffset [

	^ startAngleOffset
]

{ #category : #accessing }
ToBasicCircularLayout >> startAngleOffset: anObject [

	startAngleOffset := anObject
]
