Class {
	#name : #ToAnnulusSectorLayout,
	#superclass : #BlBasicLayout,
	#traits : 'TToAnnulusSectorLayoutState',
	#classTraits : 'TToAnnulusSectorLayoutState classTrait',
	#instVars : [
		'endAngle'
	],
	#category : #'Toplo-Widget-Circular'
}

{ #category : #constraints }
ToAnnulusSectorLayout class >> constraints [

	^ ToAnnulusSectorLayoutConstraints new
]

{ #category : #accessing }
ToAnnulusSectorLayout >> endAngle [

	^ endAngle ifNil: [ endAngle := 45 ]
]

{ #category : #accessing }
ToAnnulusSectorLayout >> endAngle: anAngleInDgrees [

	endAngle := anAngleInDgrees
]

{ #category : #layout }
ToAnnulusSectorLayout >> layout: anElement in: aBounds context: aBlElementBoundsUpdateContext [

	anElement geometry
		innerRadius: self innerRadialRatio;
		outerRadius: self outerRadialRatio;
		startAngle: self startAngle;
		endAngle: self endAngle.
	super
		layout: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext
]
