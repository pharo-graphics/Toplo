Class {
	#name : #ToAnnulusCircularLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'sectorMeasurer',
		'centroidOffset'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorAngleInDegrees: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withAngleInDegrees:
		                  aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorAngleInDegreesWithRadius: r inSectorElement: aSectorElement [

	^ sectorMeasurer ifNotNil: [ :m |
		  m angleInDegreesWithRadius: r inSectorElement: aSectorElement ]
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorAngleWeight: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withWeight: aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorArcLength: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withArcLength:
		                  aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorCentroidOffset [

	^ centroidOffset ifNil: [ centroidOffset := 0 ]
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorCentroidOffset: aNumber [

	centroidOffset := aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorChordLength: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withChordLength:
		                  aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorMeasurer [ 

	^ sectorMeasurer 
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorMeasurer: aMeasurer [

	sectorMeasurer := aMeasurer 
]
