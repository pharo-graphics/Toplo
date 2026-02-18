Class {
	#name : #ToAnnulusSectorChordMeasureStrategy,
	#superclass : #ToAnnulusSectorMeasureStrategy,
	#instVars : [
		'chordLength'
	],
	#category : #'Toplo-Widget-Circular-SectorMeasurer'
}

{ #category : #measuring }
ToAnnulusSectorChordMeasureStrategy >> angleInDegreesWithRadius: r [

	| ratio angleRad |
	(chordLength <= (2 * r)) ifFalse: [ self error: 'Chord out of range.' ].
	ratio := (chordLength / (2 * r) max: -1) min: 1.
	angleRad := 2.0 * ratio arcSin.
	^ angleRad radiansToDegrees
]

{ #category : #measuring }
ToAnnulusSectorChordMeasureStrategy >> arcLengthWithRadius: r [

	chordLength <= 2 * r ifFalse: [ self error: 'Chord out of range.' ].
	^ r * (self angleInDegreesWithRadius: r) degreesToRadians
]

{ #category : #accessing }
ToAnnulusSectorChordMeasureStrategy >> chordLength [

	^ chordLength
]

{ #category : #accessing }
ToAnnulusSectorChordMeasureStrategy >> chordLength: aNumber [

	aNumber >= 0 ifFalse: [
		self error: 'Chord must be a positive number' ].
	chordLength := aNumber
]

{ #category : #measuring }
ToAnnulusSectorChordMeasureStrategy >> chordLengthWithRadius: r [

	^ chordLength
]
