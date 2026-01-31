Class {
	#name : #ToAnnulusSectorLayout,
	#superclass : #BlBasicLayout,
	#instVars : [
		'innerRadius',
		'outerRadius',
		'startAngle',
		'endAngle'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #constraints }
ToAnnulusSectorLayout class >> constraints [

	^ ToAnnulusSectorLayoutConstraints new
]

{ #category : #accessing }
ToAnnulusSectorLayout >> endAngle [

	^ endAngle
]

{ #category : #accessing }
ToAnnulusSectorLayout >> endAngle: anObject [

	endAngle := anObject
]

{ #category : #accessing }
ToAnnulusSectorLayout >> innerRadius [

	^ innerRadius
]

{ #category : #accessing }
ToAnnulusSectorLayout >> innerRadius: anObject [

	innerRadius := anObject
]

{ #category : #layout }
ToAnnulusSectorLayout >> layout: anElement in: aBounds context: aBlElementBoundsUpdateContext [

	"anElement geometry
		innerRadius: innerRadius;
		outerRadius: outerRadius;
		startAngle: startAngle;
		endAngle: endAngle."
	super
		layout: anElement
		in: aBounds
		context: aBlElementBoundsUpdateContext
]

{ #category : #measure }
ToAnnulusSectorLayout >> measure: anElement with: anExtentSpec [

	super measure: anElement with: anExtentSpec
]

{ #category : #accessing }
ToAnnulusSectorLayout >> outerRadius [

	^ outerRadius
]

{ #category : #accessing }
ToAnnulusSectorLayout >> outerRadius: anObject [

	outerRadius := anObject
]

{ #category : #accessing }
ToAnnulusSectorLayout >> startAngle [

	^ startAngle
]

{ #category : #accessing }
ToAnnulusSectorLayout >> startAngle: anObject [

	startAngle := anObject
]
