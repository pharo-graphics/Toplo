Class {
	#name : #ToAnnulusSectorProportionalMeasureStrategy,
	#superclass : #ToAnnulusSectorMeasureStrategy,
	#instVars : [
		'weight'
	],
	#category : #'Toplo-Widget-Circular-SectorMeasurer'
}

{ #category : #measuring }
ToAnnulusSectorProportionalMeasureStrategy >> angleInDegreesWithRadius: r inSectorElement: aSectorElement [

	| start end |
	start := 0.
	end := 360.
	aSectorElement listHolderDo: [ :secH |
			secH listElement menuListOwner ifNotNil: [ :mlo |
					mlo listHolderDo: [ :ownerH |
							start := ownerH nodeContainer startAngle.
							end := ownerH nodeContainer endAngle ] ] ].
	^ weight * (self positiveDeltaFrom: start to: end)
]

{ #category : #measuring }
ToAnnulusSectorProportionalMeasureStrategy >> arcLengthWithRadius: r inSectorElement: aSectorElement [

	^ r
	  *
		  (self angleInDegreesWithRadius: r inSectorElement: aSectorElement)
			  degreesToRadians
]

{ #category : #measuring }
ToAnnulusSectorProportionalMeasureStrategy >> chordLengthWithRadius: r inSectorElement: aSectorElement [

	^ 2 * r
	  *
		  ((self angleInDegreesWithRadius: r inSectorElement: aSectorElement)
		   * 0.5) degreesToRadians sin
]

{ #category : #utilities }
ToAnnulusSectorProportionalMeasureStrategy >> positiveDeltaFrom: start to: end [

	| delta |
	delta := end - start \\ 360.
	^ (delta isZero and: [ (start closeTo: end) not ])
		  ifTrue: [ 360 ]
		  ifFalse: [ delta ]
]

{ #category : #accessing }
ToAnnulusSectorProportionalMeasureStrategy >> weight [

	^ weight
]

{ #category : #accessing }
ToAnnulusSectorProportionalMeasureStrategy >> weight: aNormalizedWeight [

	(aNormalizedWeight between: 0.0 and: 1.0) ifFalse: [
		self error: 'A normalized weight should be between 0 and 1' ].
	weight := aNormalizedWeight
]
