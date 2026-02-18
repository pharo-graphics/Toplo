Class {
	#name : #ToAnnulusSectorArcMeasureStrategy,
	#superclass : #ToAnnulusSectorMeasureStrategy,
	#instVars : [
		'arcLength'
	],
	#category : #'Toplo-Widget-Circular-SectorMeasurer'
}

{ #category : #measuring }
ToAnnulusSectorArcMeasureStrategy >> angleInDegreesWithRadius: r inSectorElement: aSectorElement [

    ^ (arcLength / r) radiansToDegrees
]

{ #category : #accessing }
ToAnnulusSectorArcMeasureStrategy >> arcLength [

	^ arcLength
]

{ #category : #accessing }
ToAnnulusSectorArcMeasureStrategy >> arcLength: aNumber [

	aNumber >= 0 ifFalse: [ self error: 'Arc must be a positive number' ].
	arcLength := aNumber
]

{ #category : #measuring }
ToAnnulusSectorArcMeasureStrategy >> arcLengthWithRadius: r  inSectorElement: aSectorElement [

	^ arcLength
]

{ #category : #measuring }
ToAnnulusSectorArcMeasureStrategy >> chordLengthWithRadius: r  inSectorElement: aSectorElement [

	| angleRad |
	angleRad := arcLength / r.
	^ 2 * r * (angleRad * 0.5) sin
]
