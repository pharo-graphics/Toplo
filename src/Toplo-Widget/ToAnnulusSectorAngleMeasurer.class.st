Class {
	#name : #ToAnnulusSectorAngleMeasurer,
	#superclass : #Object,
	#instVars : [
		'measureStrategy'
	],
	#category : #'Toplo-Widget-Circular'
}

{ #category : #instance }
ToAnnulusSectorAngleMeasurer class >> withAngleInDegrees: anAngleInDegrees [

	^ self new measureStrategy:
		  (ToAnnulusSectorAngleMeasureStrategy new angleInDegrees:
			   anAngleInDegrees)
]

{ #category : #instance }
ToAnnulusSectorAngleMeasurer class >> withArcLength: aNumber [

	^ self new measureStrategy:
		  (ToAnnulusSectorArcMeasureStrategy new arcLength: aNumber)
]

{ #category : #instance }
ToAnnulusSectorAngleMeasurer class >> withChordLength: aNumber [

	^ self new measureStrategy:
		  (ToAnnulusSectorChordMeasureStrategy new chordLength: aNumber)
]

{ #category : #instance }
ToAnnulusSectorAngleMeasurer class >> withWeight: aNumber [

	^ self new measureStrategy:
		  (ToAnnulusSectorProportionalMeasureStrategy new weight: aNumber)
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> angleInDegreesWithRadius: r inSectorElement: aSectorElement [

	^ measureStrategy
		  angleInDegreesWithRadius: r
		  inSectorElement: aSectorElement
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> arcLengthWithRadius: r inSectorElement: aSectorElement [

	^ measureStrategy
		  arcLengthWithRadius: r
		  inSectorElement: aSectorElement
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> chordLengthWithRadius: r inSectorElement: aSectorElement [

	^ measureStrategy
		  chordLengthWithRadius: r
		  inSectorElement: aSectorElement
]

{ #category : #accessing }
ToAnnulusSectorAngleMeasurer >> measureStrategy [

	^ measureStrategy
]

{ #category : #accessing }
ToAnnulusSectorAngleMeasurer >> measureStrategy: anArcMeasureStrategy [

	measureStrategy := anArcMeasureStrategy
]
