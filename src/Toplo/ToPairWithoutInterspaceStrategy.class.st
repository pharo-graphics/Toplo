Class {
	#name : #ToPairWithoutInterspaceStrategy,
	#superclass : #ToPairStrategy,
	#category : #'Toplo-Core-Pair'
}

{ #category : #layout }
ToPairWithoutInterspaceStrategy >> childrenIn: aPair [

	^ { 
		  aPair first.
		  aPair second } select: #notNil
]

{ #category : #layout }
ToPairWithoutInterspaceStrategy >> onMeasure: anExtentMeasurementSpec in: aLabeled [

	" Nothing to do "
	^ true
]
