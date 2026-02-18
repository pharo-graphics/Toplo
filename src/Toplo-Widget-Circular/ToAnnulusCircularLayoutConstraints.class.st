Class {
	#name : #ToAnnulusCircularLayoutConstraints,
	#superclass : #BlLayoutConstraints,
	#instVars : [
		'sectorMeasurer'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorAngleInDegrees: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withAngleInDegrees:
		                  aNumber
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorAngleInDegreesWithRadius: r [

	^ sectorMeasurer ifNotNil: [ :m | m angleInDegreesWithRadius: r ]
]

{ #category : #accessing }
ToAnnulusCircularLayoutConstraints >> sectorArcLength: aNumber [

	sectorMeasurer := ToAnnulusSectorAngleMeasurer withArcLength:
		                  aNumber
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
