Class {
	#name : #ToAnnulusSectorAngleMeasurer,
	#superclass : #Object,
	#instVars : [
		'measureStrategy'
	],
	#category : #'Toplo-Widget-Circular-SectorMeasurer'
}

{ #category : #'instance ' }
ToAnnulusSectorAngleMeasurer class >> withAngleInDegrees: anAngleInDegrees [

	^ self new measureStrategy:
		  (ToAnnulusSectorAngleMeasureStrategy new angleInDegrees:
			   anAngleInDegrees)
]

{ #category : #'instance ' }
ToAnnulusSectorAngleMeasurer class >> withArcLength: aNumber [

	^ self new measureStrategy:
		  (ToAnnulusSectorArcMeasureStrategy new arcLength: aNumber)
]

{ #category : #'instance ' }
ToAnnulusSectorAngleMeasurer class >> withChordLength: aNumber [

	^ self new measureStrategy:
		  (ToAnnulusSectorChordMeasureStrategy new chordLength: aNumber)
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> angleInDegreesWithRadius: r [

    ^ measureStrategy angleInDegreesWithRadius: r
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> arcLengthWithRadius: r [

    ^ measureStrategy arcLengthWithRadius: r
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasurer >> chordLengthWithRadius: r [

    ^ measureStrategy chordLengthWithRadius: r
]

{ #category : #accessing }
ToAnnulusSectorAngleMeasurer >> measureStrategy [

	^ measureStrategy
]

{ #category : #accessing }
ToAnnulusSectorAngleMeasurer >> measureStrategy: anArcMeasureStrategy [

	measureStrategy := anArcMeasureStrategy
]
