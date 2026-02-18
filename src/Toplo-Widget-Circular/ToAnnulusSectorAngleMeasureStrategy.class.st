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
ToAnnulusSectorAngleMeasureStrategy >> angleInDegreesWithRadius: r inSectorElement: aSectorElement [

    ^ angleInDegrees 
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasureStrategy >> arcLengthWithRadius: r  inSectorElement: aSectorElement [

    ^ r * angleInDegrees degreesToRadians
]

{ #category : #measuring }
ToAnnulusSectorAngleMeasureStrategy >> chordLengthWithRadius: r  inSectorElement: aSectorElement [

	^ 2 * r * (angleInDegrees * 0.5) degreesToRadians sin
]
