Class {
	#name : #ToAnnulusSectorAngleMeasureStrategy,
	#superclass : #ToAnnulusSectorMeasureStrategy,
	#instVars : [
		'angleInDegrees'
	],
	#category : #'Toplo-Widget-Circular-SectorMeasurer'
}

{ #category : #accessing }
ToAnnulusSectorAngleMeasureStrategy >> angleInDegrees [

	^ angleInDegrees
]

{ #category : #accessing }
ToAnnulusSectorAngleMeasureStrategy >> angleInDegrees: anAngleInDegrees [

	(anAngleInDegrees isNumber and: [
		 anAngleInDegrees >= 0 and: anAngleInDegrees <= 360 ]) ifFalse: [
		self error: 'Angle must be between 0 and 360.' ].
	angleInDegrees := anAngleInDegrees
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasureStrategy >> angleInDegreesWithRadius: r [

    ^ angleInDegrees 
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasureStrategy >> arcLengthWithRadius: r [

    ^ r * angleInDegrees degreesToRadians
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasureStrategy >> chordLengthWithRadius: r [

	^ 2 * r * (angleInDegrees * 0.5) degreesToRadians sin
]
