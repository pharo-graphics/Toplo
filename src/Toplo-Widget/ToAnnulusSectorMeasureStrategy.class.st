Class {
	#name : #ToAnnulusSectorMeasureStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Circular'
}

{ #category : #measuring }
ToAnnulusSectorMeasureStrategy >> angleInDegreesWithRadius: r inSectorElement: aSectorElement [

    ^ self subclassResponsibility
]

{ #category : #measuring }
ToAnnulusSectorMeasureStrategy >> arcLengthWithRadius: r  inSectorElement: aSectorElement [

    ^ self subclassResponsibility
]

{ #category : #measuring }
ToAnnulusSectorMeasureStrategy >> chordLengthWithRadius: r  inSectorElement: aSectorElement [

    ^ self subclassResponsibility
]
